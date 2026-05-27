# 자동화 설정 가이드

이 레포는 세 개의 자동화를 제공합니다:

1. **설치 스크립트** — `scripts/install.sh` (일회성)
2. **업데이트 스크립트** — `scripts/update.sh` (수동 / 크론)
3. **GitHub App 동기화** — 이 레포 `main` 갱신 → Dewy 레포에 자동 PR (**만료 없음**)

---

## 1. 일회성 설치

Dewy 레포(`weddig-planer-ai-dewy`) 루트에서 단 한 줄:

```bash
curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
```

이미 이 레포를 클론한 상태라면:

```bash
bash scripts/install.sh /path/to/weddig-planer-ai-dewy
```

설치 결과:
- `.agents/skills/*` — 10개 Dewy 맞춤 스킬
- `.agents/references/*` — 한국 웨딩 도메인 지식
- `.agents/product-marketing.md` — Dewy 컨텍스트 (이미 있으면 건너뜀)
- `.agents/scripts/update.sh` — 이후 업데이트용
- `.claude/skills` → `.agents/skills` 심볼링크
- `.agents/.dewy-marketingskills.version` — 설치된 업스트림 commit SHA

---

## 2. 수동 업데이트

Dewy 레포에서:

```bash
bash .agents/scripts/update.sh
```

동작:
- `skills/`, `references/` 을 업스트림 최신으로 완전 교체
- `.agents/product-marketing.md` 는 건들지 않음 (로컬 수정 보호)
- 업스트림의 product-marketing.md 가 바뀌면 `.agents/product-marketing.md.upstream` 로 저장 + diff 표시

---

## 3. GitHub App 자동 동기화 (권장 — 만료 없음)

이 레포 `main` 이 업데이트되면 Dewy 레포에 자동으로 PR 이 열립니다.
**GitHub App private key 는 만료가 없어** PAT 의 90일 갱신 문제가 사라집니다.

### 설정 (일회성, 30분)

#### 단계 A: GitHub App 생성

1. https://github.com/settings/apps/new 접속
2. 설정:
   - **GitHub App name**: `dewy-marketing-skills-sync` (조직이면 조직 페이지에서 생성)
   - **Homepage URL**: `https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills`
   - **Webhook → Active**: **체크 해제** (불필요)
   - **Repository permissions**:
     - Contents: **Read and write**
     - Pull requests: **Read and write**
     - Metadata: Read-only (자동)
   - **Where can this GitHub App be installed?**: **Only on this account**
3. "Create GitHub App" 클릭
4. 생성된 App 페이지에서 **App ID** 메모 (페이지 상단 "About" 섹션의 숫자)

#### 단계 B: Private key 생성

1. 같은 App 설정 페이지 하단 **Private keys** 섹션
2. "Generate a private key" 클릭 → `.pem` 파일 자동 다운로드
3. 이 파일은 **다시 받을 수 없으니** 안전하게 보관 (메모는 한 번만)

#### 단계 C: App 을 두 레포에 설치

1. App 페이지 좌측 메뉴 **Install App** 클릭
2. 본인 계정 옆 "Install" 클릭
3. **Only select repositories** 선택 후 두 레포 모두 체크:
   - `weddy_wedding_planer_ai_marketingskills`
   - `Weddig-Planer-AI-Dewy`
4. Install 클릭

#### 단계 D: 이 레포에 시크릿 두 개 등록

1. `weddy_wedding_planer_ai_marketingskills` → Settings → Secrets and variables → Actions
2. "New repository secret" 두 번:

   | Name | Value |
   |---|---|
   | `DEWY_SYNC_APP_ID` | 단계 A 에서 메모한 App ID (숫자만) |
   | `DEWY_SYNC_APP_PRIVATE_KEY` | 단계 B 의 `.pem` 파일 **전체 내용** (`-----BEGIN RSA PRIVATE KEY-----` 부터 `-----END RSA PRIVATE KEY-----` 까지) |

#### 단계 E: Dewy 레포에서 PR 자동 생성 허용

Dewy 레포 → Settings → Actions → General → Workflow permissions:
- "Allow GitHub Actions to create and approve pull requests" 체크

### 동작 확인

이 레포 `main` 에 push 하면 (또는 Actions 탭 → "Sync to Dewy" → Run workflow):

1. Action 이 App private key 로 installation token 발급 (이번 실행 한정, 1시간 유효)
2. 토큰으로 Dewy 레포에 push + PR 생성
3. `bot/sync-dewy-marketing-skills` 브랜치 → 자동 PR 올라옴
4. Dewy 팀은 검토 후 머지

### 동기화 그래뉼래리티

자동 교체 (완전 overwrite):
- `.agents/skills/`
- `.agents/references/`
- `.agents/scripts/update.sh`
- `.agents/.dewy-marketingskills.version`

보호 (로컬 수정 덮어쓰지 않음):
- `.agents/product-marketing.md` — 이미 있으면 그대로. 업스트림 변경은 `.upstream` 로.

### GitHub App vs PAT 비교

| 항목 | GitHub App (현재) | PAT (구방식) |
|---|---|---|
| 만료 | **없음** (private key 영구) | 90일 (Fine-grained 기본) |
| 갱신 작업 | 없음 | 90일마다 발급+교체 |
| 권한 범위 | App 설치 시 선택한 레포만 | 사용자 권한 그대로 |
| 사용자 종속 | 없음 (App 소유 변경 가능) | PAT 발급자 계정 정지 시 끊김 |
| Rate limit | 5,000/hr 별도 | 사용자 한도 공유 |
| 감사 추적 | App 이름으로 명확히 분리 | 사용자 이름으로 섞임 |

### Org 전환 대비

- App 을 organization 에 옮길 수 있음 (Settings → Transfer ownership)
- 시크릿도 org-level 로 옮기면 여러 레포 공유 가능

---

## 4. Dewy 코드 → product-marketing.md 동기화 알림 (선택)

Dewy 레포의 가격·서비스 정보 소스는 다음 두 곳입니다:
- `src/lib/heartPackages.ts` — 하트 패키지 가격
- `docs/service-briefing.md` — 서비스 개요

이 둘이 바뀌면 `.agents/product-marketing.md` 의 Business model 섹션도 갱신 필요. Dewy 레포에 아래 hook 을 설치하면 PR 에서 해당 파일이 바뀌었는지 알려줍니다.

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

## 5. CI 검증 (이 레포)

`.github/workflows/validate.yml` 이 모든 push/PR 에 자동 실행:
- 모든 스킬 YAML frontmatter 규칙 준수 확인
- shell 스크립트 문법 확인
- 필수 top-level 파일 존재 확인

로컬에서도 실행 가능:

```bash
bash scripts/validate.sh skills
```

---

## 6. 운영 자동화 단계

| 자동화 수준 | 필요 작업 | 권장 대상 |
|---|---|---|
| 수동 (기본) | `scripts/install.sh` 한 번 + 가끔 `update.sh` | 개인 사용 |
| 팀 (★ 권장) | GitHub App 동기화 (위 섹션 3) | 프로젝트 멤버 |
| 완전 자동 | Action + Dewy 레포 product-marketing sync hook (섹션 4) | 장기 운영 |

처음엔 단계적으로. App 설정만 해도 90일 갱신 문제가 사라지고 사람 개입 지점이 *Dewy 레포 PR 클릭 1번* 만 남습니다.
