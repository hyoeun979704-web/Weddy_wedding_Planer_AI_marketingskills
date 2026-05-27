# 자동화 설정 가이드

이 레포는 세 개의 자동화를 제공합니다:

1. **설치 스크립트** — `scripts/install.sh` (일회성)
2. **업데이트 스크립트** — `scripts/update.sh` (수동·크론)
3. **GitHub Action 동기화** — 이 레포 갱신 → Dewy 레포에 자동 PR

---

## 1. 일회성 설치

Dewy 레포(`weddig-planer-ai-dewy`) 론치 게서갌다 단 한 줄:

```bash
curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
```

이미 이 레포를 클론한 상태라면:

```bash
bash scripts/install.sh /path/to/weddig-planer-ai-dewy
```

설치 결과:
- `.agents/skills/*` — 10개 듀이 맞춤 스킬
- `.agents/references/*` — 한국 웨딩 도메인 지식
- `.agents/product-marketing.md` — 듀이 컨텍스트 (이미 있으면 건너뛰움)
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
- 업스트림 의 product-marketing.md 가 바뀜으면 `.agents/product-marketing.md.upstream` 로 저장 + diff 표시

---

## 3. GitHub Action 자동 동기화 (권장)

이 레포 `main` 가 업데이트되면 Dewy 레포에 자동으로 PR 이 열립니다.

### 설정 (일회성)

#### 단계 A: Personal Access Token (PAT) 생성

1. GitHub → Settings → Developer settings → Personal access tokens → **Fine-grained tokens**
2. "Generate new token" 클릭
3. 설정:
   - **Repository access**: Only select repositories → `hyoeun979704-web/Weddig-Planer-AI-Dewy` 선택
   - **Repository permissions**:
     - Contents: **Read and Write**
     - Pull requests: **Read and Write**
     - Metadata: Read (자동)
   - Expiration: 90일 권장 (만료 전 갱신)
4. 생성 후 토큰 복사 (한 번만 표시됨)

#### 단계 B: 토큰을 이 레포에 시크릿으로 등록

1. 이 레포(`weddy_wedding_planer_ai_marketingskills`) → Settings → Secrets and variables → Actions
2. "New repository secret" 클릭
3. Name: `DEWY_SYNC_TOKEN`
4. Value: 앞서 복사한 토큰 붙여넣기
5. Add secret

#### 단계 C: Dewy 레포에서 PR 자동 생성 허용

Dewy 레포 → Settings → Actions → General → Workflow permissions:
- "Allow GitHub Actions to create and approve pull requests" 체크

### 동작 확인

이 레포 `main` 에 push 하면 (또는 수동으로 Actions → "Sync to Dewy" → Run workflow):

1. `Sync to Dewy` 워크플로우 실행
2. Dewy 레포에 `bot/sync-dewy-marketing-skills` 브랜치 생성
3. 자동 PR 올라옴 — Dewy 팀은 검토 후 머지

### 동기화 그렌듴러리티

자동 교체 (완전 overwrite):
- `.agents/skills/`
- `.agents/references/`
- `.agents/scripts/update.sh`
- `.agents/.dewy-marketingskills.version`

보호 (로컬 수정 안 던침):
- `.agents/product-marketing.md` — 이미 있으면 그대로. 업스트림 변경은 `.upstream` 로.

---

## 4. Dewy 코드 → product-marketing.md 자동 동기화 (추가 권장)

Dewy 레포의 가격·서비스 정보 소스는 다음 두 곳입니다:
- `src/lib/heartPackages.ts` — 하트 패키지 가격
- `docs/service-briefing.md` — 서비스 개요

이 둘이 바뀌면 `.agents/product-marketing.md` 의 Business model 섹션도 갱신 필요. Dewy 레포에서 아래 hook 을 설치하면 PR 에서 해당 파일이 바뀌었는지 알려줍니다.

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
- 모든 스킬 YAML frontmatter 귀칙 준수 확인
- shell 스크립트 문법 확인
- 필수 top-level 파일 존재 확인

로컬에서도 실행 가능:

```bash
bash scripts/validate.sh skills
```

---

## 6. 최소 운영 헝짓

| 운영 자돈도 | 필요 작업 | 권장 |
|---|---|---|
| 수동 (기본) | scripts/install.sh 으로 한 번 설치 + 가끔 update.sh | 개인 사용 |
| 프로젝트 몄버 | GitHub Action 동기화 설정 (위 세션 3) | ★ 팀 혜용 |
| 완전 자동 | Action + Dewy repo 에서 product-marketing sync hook | 장기 |

처음엔 이 세 단계를 단계적으로 올리면 됩니다. Action 설정만 해도 행복도 수준이 상당히 올라갑니다.
