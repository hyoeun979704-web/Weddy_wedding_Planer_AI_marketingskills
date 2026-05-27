#!/usr/bin/env bash
# Dewy Marketing Skills — updater
#
# Usage:
#   bash .agents/scripts/update.sh                       # 현재 레포 루트에서
#   bash .agents/scripts/update.sh /path/to/dewy         # 명시적 경로
#
# 동작:
#   - skills/, references/ 는 upstream 으로 완전 교체 (로컬 수정 안 뎨 전제)
#   - .agents/product-marketing.md 는 건드리지 않고, upstream 변경의 diff 만 별도 저장
#   - .dewy-marketingskills.version 갱신

set -euo pipefail

DEWY_DIR="${1:-${DEWY_DIR:-$(pwd)}}"
REPO_URL="https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills.git"
REPO_BRANCH="${REPO_BRANCH:-main}"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

log()  { echo "[update] $*"; }
fail() { echo "[update] ERROR: $*" >&2; exit 1; }

[[ -d "$DEWY_DIR/.agents" ]] || fail "$DEWY_DIR/.agents 없음. install.sh 먼저 실행."

log "target: $DEWY_DIR"
log "fetch upstream..."
git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$TMP_DIR/repo" >/dev/null 2>&1

NEW_SHA=$(git -C "$TMP_DIR/repo" rev-parse HEAD)
OLD_SHA=$(cat "$DEWY_DIR/.agents/.dewy-marketingskills.version" 2>/dev/null || echo "")

if [[ "$NEW_SHA" == "$OLD_SHA" ]]; then
  log "이미 최신입니다 ($OLD_SHA)"
  exit 0
fi

log "$OLD_SHA → $NEW_SHA"

rm -rf "$DEWY_DIR/.agents/skills" "$DEWY_DIR/.agents/references"
mkdir -p "$DEWY_DIR/.agents/skills" "$DEWY_DIR/.agents/references"
cp -r "$TMP_DIR/repo/skills/." "$DEWY_DIR/.agents/skills/"
cp -r "$TMP_DIR/repo/references/." "$DEWY_DIR/.agents/references/"
log "skills/ + references/ 교체 완료"

# product-marketing.md 차이 시 별도 저장
UP="$TMP_DIR/repo/.agents/product-marketing.md"
LOCAL="$DEWY_DIR/.agents/product-marketing.md"
if [[ -f "$LOCAL" && -f "$UP" ]]; then
  if ! diff -q "$LOCAL" "$UP" >/dev/null 2>&1; then
    cp "$UP" "$DEWY_DIR/.agents/product-marketing.md.upstream"
    log "upstream product-marketing.md 변경 감지. 차이:"
    diff -u "$LOCAL" "$UP" | head -60 || true
    log "업스트림 버전: .agents/product-marketing.md.upstream"
    log "검토 후 수동으로 병합하세요."
  fi
elif [[ -f "$UP" && ! -f "$LOCAL" ]]; then
  cp "$UP" "$LOCAL"
  log "product-marketing.md 신규 설치"
fi

echo "$NEW_SHA" > "$DEWY_DIR/.agents/.dewy-marketingskills.version"
log "업데이트 완료: $NEW_SHA"
