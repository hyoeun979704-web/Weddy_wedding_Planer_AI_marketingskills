#!/usr/bin/env bash
# Dewy Marketing Skills — validator
#
# 역할: skills/ 하위 각 SKILL.md 의 YAML frontmatter 검증
#   - name 이 디렉토리명과 일치하는가
#   - name 이 규칙 준수 (소문자 + 숫자 + 하이픈, 연속 하이픈 불가)
#   - description 길이 1—1024 자
#   - SKILL.md 존재
#   - 500 줄 초과 시 경고
#
# Usage:
#   bash scripts/validate.sh           # skills/ 검증
#   bash scripts/validate.sh path/skills

set -euo pipefail
SKILLS_DIR="${1:-skills}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 가 필요합니다." >&2
  exit 1
fi

python3 - "$SKILLS_DIR" <<'PY'
import os, re, sys

skills_dir = sys.argv[1]
if not os.path.isdir(skills_dir):
    print(f"[validate] {skills_dir} 없음", file=sys.stderr)
    sys.exit(1)

NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
errors = []
warnings = []
ok = []

for name in sorted(os.listdir(skills_dir)):
    path = os.path.join(skills_dir, name)
    if not os.path.isdir(path):
        continue
    skill_md = os.path.join(path, "SKILL.md")
    if not os.path.isfile(skill_md):
        errors.append(f"[{name}] SKILL.md 없음")
        continue
    text = open(skill_md, encoding="utf-8").read()
    m = re.match(r"^---\n(.*?)\n---\n", text, re.DOTALL)
    if not m:
        errors.append(f"[{name}] YAML frontmatter 없음")
        continue
    fm = m.group(1)

    name_m = re.search(r"^name:\s*(.+?)\s*$", fm, re.MULTILINE)
    if not name_m:
        errors.append(f"[{name}] name 필드 없음")
        continue
    skill_name = name_m.group(1).strip().strip('"\'')

    if skill_name != name:
        errors.append(f"[{name}] name='{skill_name}' 이 디렉토리명과 다름")

    if not NAME_RE.match(skill_name):
        errors.append(f"[{name}] name='{skill_name}' 규칙 위반 (lowercase a-z, 0-9, hyphen, no '--')")

    if '--' in skill_name:
        errors.append(f"[{name}] name 에 연속 하이픈 '--' 포함")

    desc_m = re.search(r'^description:\s*"((?:[^"\\]|\\.)*)"\s*$', fm, re.MULTILINE)
    if not desc_m:
        desc_m = re.search(r"^description:\s*(.+?)\s*$", fm, re.MULTILINE)
    if not desc_m:
        errors.append(f"[{name}] description 없음")
        continue
    desc = desc_m.group(1).strip().strip('"\'')

    if not (1 <= len(desc) <= 1024):
        errors.append(f"[{name}] description 길이 {len(desc)}자 (1—1024 필요)")

    line_count = text.count("\n")
    if line_count > 500:
        warnings.append(f"[{name}] SKILL.md {line_count}줄 (권장 <500)")

    ok.append(f"OK   [{name}]  desc={len(desc)}ch  lines={line_count}")

for line in ok:
    print(line)

if warnings:
    print("\n[warnings]")
    for w in warnings:
        print(" ", w)

if errors:
    print("\n[errors]")
    for e in errors:
        print(" ", e)
    sys.exit(1)

print(f"\n✓ {len(ok)} skills valid")
PY
