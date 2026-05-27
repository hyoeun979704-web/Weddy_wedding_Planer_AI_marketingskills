#!/usr/bin/env bash
# Dewy Marketing Skills — installer
#
# Usage (대상 레포는 Dewy(weddig-planer-ai-dewy) 론치):
#   curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
#
# 또는 이미 클론한 상태에서:
#   bash scripts/install.sh /path/to/weddig-planer-ai-dewy
#
# 환경 변수:
#   REPO_BRANCH (기본: main)
#   DEWY_DIR    (기본: 인자 또는 현재 디렉토리)

set -euo pipefail

DEWY_DIR="${1:-${DEWY_DIR:-$(pwd)}}"
REPO_URL="https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills.git"
REPO_BRANCH="${REPO_BRANCH:-main}"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

log()  { echo "[install] $*"; }
warn() { echo "[install] WARN: $*" >&2; }
fail() { echo "[install] ERROR: $*" >&2; exit 1; }

[[ -d "$DEWY_DIR" ]] || fail "$DEWY_DIR 가 존재하지 않습니다."

# Dewy 레포인지 대랛 확인
if [[ ! -f "$DEWY_DIR/package.json" ]]; then
  warn "$DEWY_DIR 에 package.json 이 없습니다 — Dewy 레포가 맞나요?"
elif ! grep -q '"name":[[:space:]]*"dewy"' "$DEWY_DIR/package.json"; then
  warn "package.json 의 name 이 'dewy' 가 아닙니다. 계속합니다."
fi

log "target: $DEWY_DIR"
log "source: $REPO_URL ($REPO_BRANCH)"

log "clone marketingskills..."
git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$TMP_DIR/repo" >/dev/null 2>&1
NEW_SHA=$(git -C "$TMP_DIR/repo" rev-parse HEAD)

mkdir -p "$DEWY_DIR/.agents/skills" "$DEWY_DIR/.agents/references" "$DEWY_DIR/.agents/scripts"

log "copy skills/..."
rm -rf "$DEWY_DIR/.agents/skills/"*
cp -r "$TMP_DIR/repo/skills/." "$DEWY_DIR/.agents/skills/"

log "copy references/..."
rm -rf "$DEWY_DIR/.agents/references/"*
cp -r "$TMP_DIR/repo/references/." "$DEWY_DIR/.agents/references/"

log "copy update.sh into .agents/scripts/ ..."
cp "$TMP_DIR/repo/scripts/update.sh" "$DEWY_DIR/.agents/scripts/update.sh"
chmod +x "$DEWY_DIR/.agents/scripts/update.sh" 2>/dev/null || true

# product-marketing.md 은 기존 것이 있으면 더하지 않음 (로컬 수정 보호)
if [[ -f "$DEWY_DIR/.agents/product-marketing.md" ]]; then
  log ".agents/product-marketing.md 이미 존재 — 건너뛰어 끝. 업데이트 필요시 update.sh 사용."
else
  log "install .agents/product-marketing.md"
  cp "$TMP_DIR/repo/.agents/product-marketing.md" "$DEWY_DIR/.agents/product-marketing.md"
fi

# Claude Code 호환용 심볼링크
if [[ ! -e "$DEWY_DIR/.claude/skills" ]]; then
  mkdir -p "$DEWY_DIR/.claude"
  (cd "$DEWY_DIR/.claude" && ln -sf ../.agents/skills skills) && log "create .claude/skills symlink"
fi

echo "$NEW_SHA" > "$DEWY_DIR/.agents/.dewy-marketingskills.version"
log "installed version: $NEW_SHA"

cat <<'POST'
[install] 완료.

다음 단계:
  1. .agents/product-marketing.md 검토 (필요시 Dewy 수치·서비스 정보 업데이트)
  2. Claude Code 에서 시험: /copywriting, /aso, /onboarding, /churn-prevention 등
  3. 주기적 업데이트: bash .agents/scripts/update.sh
POST
