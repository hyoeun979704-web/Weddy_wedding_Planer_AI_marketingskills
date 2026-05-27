#!/usr/bin/env bash
# Dewy Marketing Skills — install or update (idempotent)
#
# Usage (Dewy 레포 루트에서):
#   curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
#
# 또는 이 레포를 클론한 상태:
#   bash scripts/install.sh /path/to/weddig-planer-ai-dewy
#
# 동작:
#   - .agents/skills/, .agents/references/ 설치 또는 교체
#   - .agents/product-marketing.md 설치 (이미 있으면 건너뜀 — 로컬 수정 보호)
#   - .gitignore 자동 등록 (Dewy 레포 git history 에 동기화 파일이 안 들어감)
#   - .claude/skills 심볼링크 (Claude Code 호환)
#
# 처음 실행도, 업데이트도 같은 명령. 완전히 idempotent.

set -euo pipefail

DEWY_DIR="${1:-${DEWY_DIR:-$(pwd)}}"
REPO_URL="https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills.git"
REPO_BRANCH="${REPO_BRANCH:-main}"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

log()  { echo "[dewy-mkt] $*"; }
warn() { echo "[dewy-mkt] WARN: $*" >&2; }
fail() { echo "[dewy-mkt] ERROR: $*" >&2; exit 1; }

[[ -d "$DEWY_DIR" ]] || fail "$DEWY_DIR 가 존재하지 않습니다."

# Dewy 레포인지 대략 확인
if [[ ! -f "$DEWY_DIR/package.json" ]]; then
  warn "$DEWY_DIR 에 package.json 이 없습니다 — Dewy 레포가 맞나요?"
elif ! grep -q '"name":[[:space:]]*"dewy"' "$DEWY_DIR/package.json"; then
  warn "package.json 의 name 이 'dewy' 가 아닙니다. 계속합니다."
fi

OLD_SHA=$(cat "$DEWY_DIR/.agents/.dewy-marketingskills.version" 2>/dev/null || echo "")
ACTION=$([[ -z "$OLD_SHA" ]] && echo "install" || echo "update")

log "target: $DEWY_DIR ($ACTION)"
log "source: $REPO_URL ($REPO_BRANCH)"

log "fetch upstream..."
git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$TMP_DIR/repo" >/dev/null 2>&1
NEW_SHA=$(git -C "$TMP_DIR/repo" rev-parse HEAD)

if [[ "$NEW_SHA" == "$OLD_SHA" ]]; then
  log "이미 최신 ($OLD_SHA) — 변경 없음"
  exit 0
fi

mkdir -p "$DEWY_DIR/.agents/skills" "$DEWY_DIR/.agents/references"

log "sync skills/..."
rm -rf "$DEWY_DIR/.agents/skills/"*
cp -r "$TMP_DIR/repo/skills/." "$DEWY_DIR/.agents/skills/"

log "sync references/..."
rm -rf "$DEWY_DIR/.agents/references/"*
cp -r "$TMP_DIR/repo/references/." "$DEWY_DIR/.agents/references/"

# product-marketing.md — 첫 설치 시에만 복사, 이후엔 절대 덮어쓰지 않음 (Dewy 비즈니스 컨텍스트)
if [[ ! -f "$DEWY_DIR/.agents/product-marketing.md" ]]; then
  log "install .agents/product-marketing.md (first time — commit 권장)"
  cp "$TMP_DIR/repo/.agents/product-marketing.md" "$DEWY_DIR/.agents/product-marketing.md"
else
  # upstream 이 바뀌었으면 .upstream 으로 별도 저장 (사용자 수동 비교용)
  if ! diff -q "$DEWY_DIR/.agents/product-marketing.md" "$TMP_DIR/repo/.agents/product-marketing.md" >/dev/null 2>&1; then
    cp "$TMP_DIR/repo/.agents/product-marketing.md" "$DEWY_DIR/.agents/product-marketing.md.upstream"
    log "upstream product-marketing.md 변경 감지 → .agents/product-marketing.md.upstream 저장"
    log "diff 확인: diff .agents/product-marketing.md .agents/product-marketing.md.upstream"
  fi
fi

# Claude Code 호환 심볼링크
if [[ ! -e "$DEWY_DIR/.claude/skills" ]]; then
  mkdir -p "$DEWY_DIR/.claude"
  (cd "$DEWY_DIR/.claude" && ln -sf ../.agents/skills skills) && log "create .claude/skills symlink"
fi

echo "$NEW_SHA" > "$DEWY_DIR/.agents/.dewy-marketingskills.version"

# .gitignore 자동 등록 — 동기화 파일이 Dewy 레포 git 에 안 들어가도록
GITIGNORE="$DEWY_DIR/.gitignore"
ENTRIES=(
  "# Dewy Marketing Skills — synced from upstream, do not commit"
  ".agents/skills/"
  ".agents/references/"
  ".agents/.dewy-marketingskills.version"
  ".agents/product-marketing.md.upstream"
  ".claude/skills"
)

[[ -f "$GITIGNORE" ]] || { log "create .gitignore"; touch "$GITIGNORE"; }

MISSING=0
for entry in "${ENTRIES[@]}"; do
  grep -qxF "$entry" "$GITIGNORE" 2>/dev/null || MISSING=1
done

if [[ $MISSING -eq 1 ]]; then
  log "add gitignore entries"
  # 마지막 줄에 개행 없으면 추가
  if [[ -s "$GITIGNORE" ]] && [[ -n "$(tail -c 1 "$GITIGNORE")" ]]; then
    echo "" >> "$GITIGNORE"
  fi
  echo "" >> "$GITIGNORE"
  for entry in "${ENTRIES[@]}"; do
    grep -qxF "$entry" "$GITIGNORE" 2>/dev/null || echo "$entry" >> "$GITIGNORE"
  done
fi

log "done ($ACTION). version: $NEW_SHA"

cat <<'POST'

[dewy-mkt] 다음 단계:
  1. .agents/product-marketing.md 확인 (수치·서비스 정보 최신인지)
     → 이 파일은 commit 권장 (Dewy 비즈니스 컨텍스트, 12KB)
  2. .gitignore 변경분 commit (스킬·references 가 git history 에 안 들어감)
  3. Claude Code 에서 시험: /copywriting /aso /onboarding /churn-prevention
  4. 업데이트 = 같은 한 줄 다시:
     curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
POST
