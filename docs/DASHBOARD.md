# Dewy Marketing Skills 대시보드

스킬 40종을 한눈에 보고, 국분별 필터·검색하고, 버튼 1번으로 프롬프트를 복사해 Claude Code 에서 즉시 쓸 수 있는 정적 페이지.

---

## 1. 활성화 (일회성, 3분)

### 단계 A: GitHub Pages 활성화

1. 이 레포 → Settings → Pages
2. **Source**: GitHub Actions 선택 (Branch 아님)
3. Save

### 단계 B: 첫 빌드 트리거

`main` 에 머지하면 `Build Dashboard` 워크플로우가 자동 실행. 또는 수동으로:

- Actions 탭 → "Build Dashboard" → Run workflow

### 단계 C: 확인

빌드 완료 후 아래 URL 로 접근:

```
https://hyoeun979704-web.github.io/weddy_wedding_planer_ai_marketingskills/
```

(실제 URL 은 Pages 설정 페이지에 표시됨.)

---

## 2. 기능

- **스킬 카드 40개** — Dewy 맞춤 10 + 업스트림 30
- **한글·영문명 병기** — `cro` → 전환율 최적화, `aso` → 앱 스토어 최적화 등
- **카테고리 필터** — 콘텐츠 / 전환 / 발견 / 유료광고 / 전략 / 유지 / 성장공학 / B2B / 실험·분석
- **검색** — 한글·영문 둘 다
- **사용 예시** — 자연어 프롬프트 3개씩
- **실행 버튼 2개**:
  - 📋 프롬프트 복사 — 슬래시 커맨드 (`/copywriting` 등) 클립보드 복사
  - 🚀 Claude.ai 열기 — https://claude.ai/code 새 탭 (`?q=` 프롬프트 포함)
- **자동화 상태 모니터** — 상단의 validate / sync-to-dewy / build-dashboard 배지

---

## 3. 자동 갱신

`main` 에 스킬 또는 대시보드 파일 변경 이 머지되면 자동 재빌드·재배포. `paths` 필터 때문에 README 만 바꾸면 트리거 안 됨.

---

## 4. 로컬 미리보기

```bash
python3 dashboard/build.py
# dist/index.html 생성— 브라우저에서 직접 열어 확인
```

또는 간단한 로컬 서버:

```bash
python3 dashboard/build.py && cd dist && python3 -m http.server 8000
# http://localhost:8000
```

---

## 5. Slack/Discord 알림 (선택)

`notify.yml` 워크플로우가 sync · validate · build-dashboard 종료마다 메시지를 보냅니다. **`NOTIFY_WEBHOOK_URL` 시크릿이 없으면 조용히 건너뛰니 안전함**.

### Slack 설정

1. Slack workspace → Apps → "Incoming Webhooks" 설치
2. 채널 선택 → "Add Incoming WebHooks Integration"
3. Webhook URL 복사 (https://hooks.slack.com/services/...)
4. 이 레포 → Settings → Secrets → New repository secret
5. Name: `NOTIFY_WEBHOOK_URL` / Value: 복사한 URL

### Discord 설정

1. 채널 설정 → Integrations → Webhooks → New Webhook
2. Copy Webhook URL
3. **URL 끝에 `/slack` 추가** (Slack 포맷 호환성): `https://discord.com/api/webhooks/.../slack`
4. 이 레포 → Secrets → `NOTIFY_WEBHOOK_URL` = 위 URL

### 메시지 예시

```
✅ *Sync to Dewy* 성공
· 브랜치: `main`
· 실행: hyoeun979704-web
· <https://github.com/.../runs/...|로그 보기>
```

---

## 6. Custom Domain (선택)

더 짧은 URL 을 원하면:

1. 도메인 (예: skills.dewy-wedding.com) DNS CNAME 을 `hyoeun979704-web.github.io` 로
2. 이 레포 → Settings → Pages → Custom domain 입력
3. Enforce HTTPS 체크

---

## 7. 제한·주의점

- Claude.ai 의 `?q=` 프롬프트 일채 기능은 클라이언트 버전에 따라 지원 여부가 달라질 수 있음. 안 되면 클립보드 복사 후 붙여넣기.
- 대시보드는 정적 페이지이므로 **사용량 통계** (누가 어떤 스킬을 쓴는지)는 표시 안 됨. 그건 텔레메트리 옵션 (이전 대화에서 논의한 "C 옵션")이 필요.
- GitHub Pages 는 public 접근. 레포가 private 이어도 Pages 자체는 public. 민감한 정보 올리지 말 것.
