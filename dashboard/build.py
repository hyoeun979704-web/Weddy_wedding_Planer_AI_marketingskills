#!/usr/bin/env python3
"""Build static dashboard from data.json + skills/*."""
import json, re, shutil, subprocess
from pathlib import Path

ROOT = Path(__file__).parent.parent
DASHBOARD = ROOT / "dashboard"
SKILLS_DIR = ROOT / "skills"
DIST = ROOT / "dist"

def parse_frontmatter(text: str) -> dict:
    m = re.match(r"^---\n(.*?)\n---\n", text, re.DOTALL)
    if not m:
        return {}
    fm = m.group(1)
    name_m = re.search(r"^name:\s*(.+?)\s*$", fm, re.MULTILINE)
    desc_m = (re.search(r'^description:\s*"((?:[^"\\]|\\.)*)"', fm, re.MULTILINE) or
              re.search(r"^description:\s*(.+?)\s*$", fm, re.MULTILINE))
    return {
        "name": name_m.group(1).strip().strip('"').strip("'") if name_m else None,
        "description": desc_m.group(1).strip() if desc_m else "",
    }

def git_head_sha() -> str:
    try:
        return subprocess.check_output(["git", "-C", str(ROOT), "rev-parse", "HEAD"]).decode().strip()[:7]
    except Exception:
        return "unknown"

def git_head_date() -> str:
    try:
        return subprocess.check_output(["git", "-C", str(ROOT), "log", "-1", "--format=%cd", "--date=short"]).decode().strip()
    except Exception:
        return "unknown"

def main():
    data = json.loads((DASHBOARD / "data.json").read_text(encoding="utf-8"))

    # 실제 skills/ 디렉토리의 frontmatter description 을 재궁에 맞춰 주입
    for skill in data["customized"]:
        skill_md = SKILLS_DIR / skill["name"] / "SKILL.md"
        if skill_md.exists():
            fm = parse_frontmatter(skill_md.read_text(encoding="utf-8"))
            skill["description"] = fm.get("description", "")

    sha = git_head_sha()
    date = git_head_date()
    customized_count = len(data["customized"])
    upstream_count = len(data["upstream"])

    template = (DASHBOARD / "template.html").read_text(encoding="utf-8")
    # 스크립트 증함 제거: </ → <\/
    safe_json = json.dumps(data, ensure_ascii=False).replace("</", "<\\/")
    page = (template
        .replace("__DATA_JSON__", safe_json)
        .replace("__BUILD_SHA__", sha)
        .replace("__BUILD_DATE__", date)
        .replace("__CUSTOMIZED_COUNT__", str(customized_count))
        .replace("__UPSTREAM_COUNT__", str(upstream_count)))

    DIST.mkdir(exist_ok=True)
    (DIST / "index.html").write_text(page, encoding="utf-8")
    for asset in ["style.css", "app.js"]:
        shutil.copy(DASHBOARD / asset, DIST / asset)

    print(f"✓ built {customized_count} customized + {upstream_count} upstream skills")
    print(f"  output: {DIST/'index.html'}")

if __name__ == "__main__":
    main()
