# 자동화 설정 가이드

이 레포는 다음을 제공합니다:

1. **설치/업데이트 스크립트** — `scripts/install.sh` (idempotent, .gitignore 자동 등록)
2. **CI 검증** — `validate.yml` 자동
3. **대시보드 자동 빌드** — `build-dashboard.yml` (별도 가이드: `docs/DASHBOARD.md`)
4. **선택: Slack/Discord 알림** — `notify.yml`

---

## 1. Dewy 레포에 설치 / 업데이트

처음 설치도, 이후 업데이트도 **같은 한 줄**:

```bash
curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
```

스크립트 동작:
- `.agents/skills/`, `.agents/references/` 설치 또는 교체
- `.agents/product-marketing.md` 설치 (이미 있으면 건너뜀 — 로컬 수정 보호)
- `.claude/skills` 심볼링크 생성
- **`.gitignore` 에 동기화 파일 자동 등록** ← Dewy 레포가 부풀지 않음
- 버전 SHA 기록 (`.agents/.dewy-marketingskills.version`)

재실행 시 idempotent — 이미 최신이면 아무것도 안 함.

### Dewy 레포에 무엇이 git 커밋되나?

| 파일 | git | 이유 |
|---|---|---|
| `.agents/product-marketing.md` | ✅ **commit 권장** | Dewy 비즈니스 컨텍스트, 팀 자산 (~12KB) |
| `.gitignore` (자동 추가된 entries) | ✅ commit | 동기화 파일 추적 제외 규칙 |
| `.agents/skills/` | ❌ gitignored | 업스트림에서 항상 동일 동기화 가능 |
| `.agents/references/` | ❌ gitignored | 동상 |
| `.agents/.dewy-marketingskills.version` | ❌ gitignored | 로컬 상태 |
| `.agents/product-marketing.md.upstream` | ❌ gitignored | 비교용 임시 파일 |
| `.claude/skills` (symlink) | ❌ gitignored | 로컬 환경 호환 |

→ Dewy 레포에 영구 추가되는 실파일은 `.agents/product-marketing.md` 1개 (~12KB).

### 팀원 새 환경 셋업

Dewy 레포 clone 후:

```bash
curl ... install.sh | bash   # 1줄, 끝
```

별도 cron, 자동 PR 셋업, GitHub App, PAT 모두 **불필요**.

### 업데이트 인지 방법

이 레포가 갱신됐는지 알고 싶다면:

- 옵션 1: 대시보드 (https://hyoeun979704-web.github.io/weddy_wedding_planer_ai_marketingskills/) 헤더의 버전 SHA 확인
- 옵션 2: Slack/Discord 알림 봇 (`notify.yml` + 시크릿 등록, 섹션 4 참조)
- 옵션 3: GitHub watch (이 레포 우측 상단 "Watch" 활성화)

---

## 2. CI 검증 (이 레포)

`.github/workflows/validate.yml` 이 모든 push/PR 에 자동 실행:
- 모든 스킬 YAML frontmatter 규칙 준수 확인
- shell 스크립트 문법 확인
- 필수 top-level 파일 존재 확인

로컬에서도 실행 가능:

```bash
bash scripts/validate.sh skills
```

---

## 3. 대시보드 자동 빌드

`.github/workflows/build-dashboard.yml` 이 main push 마다 GitHub Pages 재배포. 설정 가이드는 [`docs/DASHBOARD.md`](DASHBOARD.md).

---

## 4. Slack/Discord 알림 (선택)

`.github/workflows/notify.yml` 이 다른 워크플로우 종료 시 채널에 알림. `NOTIFY_WEBHOOK_URL` 시크릿이 없으면 조용히 건너뜀.

셋업 가이드: [`docs/DASHBOARD.md`](DASHBOARD.md) 섹션 5.

이 알림이 사실상 "이 레포가 갱신됐다 → Dewy 측에서 install.sh 재실행하라" 신호 역할.

---

## 5. Dewy 코드 → product-marketing.md 동기화 알림 (선택, Dewy 레포 측)

Dewy 레포의 가격·서비스 정보 소스:
- `src/lib/heartPackages.ts` — 하트 패키지 가격
- `docs/service-briefing.md` — 서비스 개요

이 둘이 바뀌면 `.agents/product-marketing.md` 의 Business model 섹션도 갱신 필요. 아래 hook 을 Dewy 레포에 설치하면 PR 에서 알려줍니다:

```yaml
# Dewy repo 에 추가: .github/workflows/check-product-marketing-sync.yml
name: product-marketing.md sync check

on:
  pull_request:
    paths:
      - 'src/lib/heartPackages.ts'
      - 'docs/service-briefing.md'

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Remind to update product-marketing.md
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '⚠️ 가격/서비스 정보 소스가 변경되었습니다. `.agents/product-marketing.md` 의 "Business model" / "Product Overview" 섹션도 동일하게 갱신했는지 확인해주세요.'
            })
```

---

## 6. 운영 비용

| 항목 | 비용 |
|---|---|
| GitHub Actions (validate, build-dashboard, notify) | 무료 (월 5~10분) |
| GitHub Pages 호스팅 | 무료 |
| GitHub App / PAT | **불필요** (.gitignore 방식이라 cross-repo 토큰 필요 없음) |
| 시간 | 거의 0 (이 레포 갱신 시 install.sh 한 줄) |

---

## 7. 운영 자동화 단계

| 자동화 수준 | 필요 작업 | 권장 대상 |
|---|---|---|
| 기본 (★ 권장) | `install.sh` 한 줄 + 가끔 같은 명령 재실행 | 대부분의 경우 |
| 알림 추가 | + Slack/Discord 시크릿 등록 (5분) | 팀 단위 |
| 풀 자동 (옵션) | + Dewy 레포 product-marketing sync hook (섹션 5) | 장기 운영 |

무거운 cross-repo 자동화는 사라졌고, 이제 운영 비용 사실상 0.
