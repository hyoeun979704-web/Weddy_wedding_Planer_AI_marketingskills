# Dewy Marketing Skills

**한국 결혼 시장 특화 AI 웨딩 플래너 [Dewy(듀이)](https://dewy-wedding.com) 를 위한 마케팅 스킬 모음.**

[![Validate Skills](https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/actions/workflows/validate.yml/badge.svg)](https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/actions/workflows/validate.yml)
[![Build Dashboard](https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/actions/workflows/build-dashboard.yml/badge.svg)](https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/actions/workflows/build-dashboard.yml)

[coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) 의 40개 스킬을 기반으로, Dewy 서비스 컨텍스트(한국 웨딩 시장, 카카오/네이버 생태계, 하트·구독 수익 모델, 커플 동시 사용 등)에 맞춰 재구성했습니다.

🎛 **[대시보드 열기](https://hyoeun979704-web.github.io/weddy_wedding_planer_ai_marketingskills/)** — 스킬 40종 카드, 한글명 병기, 클릭 한 번으로 프롬프트 복사

---

## 무엇이 다른가?

| 영역 | Upstream marketingskills | Dewy Marketing Skills |
|---|---|---|
| **Product context** | 사용자가 직접 작성 | `.agents/product-marketing.md` 에 Dewy 정보 사전 작성 |
| **시장** | 글로벌 (영어권 SaaS 기본) | 한국 결혼 시장 (스드메·예단·예식 문화) |
| **광고 채널** | Google / Meta / LinkedIn / Twitter | **Naver / Kakao Moment** + Google / Meta |
| **SNS** | LinkedIn / Twitter / Instagram | **KakaoStory / Naver Blog / Instagram / YouTube Shorts** |
| **앱 스토어** | Apple App Store + Google Play (글로벌) | **Google Play (한국)** + One Store 보조 |
| **SEO** | Google 중심 | **Naver + Google** 듀얼 트래픽 |
| **결제 / 가격** | 일반 SaaS 구독 | **하트 충전(Toss) + Premium 구독(KakaoPay) + B2B** |
| **타깃 페르소나** | B2B 의사결정권자 | **25–45세 한국 예비 신랑·신부 + 부모 + B2B 사업자** |
| **타이밍 / 라이프사이클** | 일반 SaaS 리텐션 | **예식일 D-day 기반** (Pre-engagement → 결혼 직후 churn 절벽) |

---

## 빠른 시작 (한 줄)

Dewy 레포 루트에서:

```bash
curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
```

이 스크립트가 자동으로:
- `.agents/skills/`, `.agents/references/` 설치 (Dewy 레포에는 미커밋)
- `.agents/product-marketing.md` 설치 (Dewy 비즈니스 컨텍스트, **commit 권장**)
- `.gitignore` 자동 등록 → 동기화 파일은 git history 에 안 들어감
- `.claude/skills` 심볼링크

**Dewy 레포에 영구 추가되는 것**: `.agents/product-marketing.md` (~12KB) + `.gitignore` 한 줄. 그 외 모두 gitignored.

### 업데이트

같은 한 줄 다시 실행. 스크립트는 idempotent — 이미 최신이면 아무것도 안 함.

```bash
curl -fsSL https://raw.githubusercontent.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills/main/scripts/install.sh | bash
```

알림을 받고 싶으면 `notify.yml` 에 Slack/Discord webhook 시크릿만 등록 (`docs/DASHBOARD.md` 섹션 5). 이 레포 갱신 시 채널로 자동 알림.

---

## 사용

Dewy 코드베이스 안에서 자연어로 요청:

```
"AI 플래너 첫 사용자 활성화율을 높이고 싶어"
→ /onboarding 스킬 호출

"카카오모먼트 광고 카피 5개 만들어줘"
→ /ads 스킬 (Naver/Kakao 우선 매핑)

"Premium 구독 paywall 카피 다듬자"
→ /paywalls + /copywriting

"네이버 검색 노출 늘리는 방안"
→ /seo-audit
```

대시보드에서 한글명·예시 보고 클릭 한 번으로 프롬프트 복사도 가능합니다.

---

## 포함된 스킬 (Dewy 맞춤 10종)

| 스킬 | 한글명 | 핵심 차이 |
|---|---|---|
| [copywriting](skills/copywriting/) | 카피라이팅 | 한국 웨딩 톤, 존댓말/반말, 신랑·신부 호칭, 스드메 용어 |
| [aso](skills/aso/) | 앱 스토어 최적화 | Google Play 한국 / One Store, 한국어 키워드 |
| [ads](skills/ads/) | 유료 광고 | Naver GFA / 카카오모먼트 우선, Google·Meta 보조 |
| [social](skills/social/) | 소셜 미디어 | 인스타 릴스, 네이버 블로그, KakaoStory, 카카오 채널 |
| [customer-research](skills/customer-research/) | 고객 조사 | 한국 예비부부 페르소나 (D-Day 기반), 부모 페르소나 |
| [pricing](skills/pricing/) | 가격 정책 | 하트 단가, Premium 월/연 구독, 환불 정책 |
| [onboarding](skills/onboarding/) | 온보딩 | D-Day 입력 → 골든타임 추천, AI 플래너 첫 사용 |
| [churn-prevention](skills/churn-prevention/) | 이탈 방지 | 예식 직후 churn 절벽, 신혼부부 LTV 연장 |
| [cro](skills/cro/) | 전환율 최적화 | 하트 충전·구독 전환 퍼널, 커플 연동 활성화 |
| [seo-audit](skills/seo-audit/) | SEO 진단 | Naver SEO + Google 듀얼, 한국 결혼 키워드 클러스터 |

나머지 30개 스킬은 [references/upstream-skills-map.md](references/upstream-skills-map.md) 에서 upstream marketingskills 와 Dewy 활용 가이드를 매핑해 두었습니다.

---

## 자동화

이 레포가 처리:

| 자동화 | 역할 | 트리거 |
|---|---|---|
| [`validate.yml`](.github/workflows/validate.yml) | 스킬 YAML 검증 + shell 문법 + 필수 파일 | push / PR |
| [`build-dashboard.yml`](.github/workflows/build-dashboard.yml) | GitHub Pages 대시보드 재빌드·배포 | main 푸시 |
| [`notify.yml`](.github/workflows/notify.yml) | Slack/Discord 채널로 워크플로우 결과 알림 (시크릿 등록 시) | 다른 워크플로우 종료 시 |

Dewy 측 동기화는 `install.sh` 한 줄로 충분하므로 cross-repo 토큰·App 셋업 불필요. **연 운영 비용 0원, 시간 거의 0**.

### 셋업 가이드

- [`docs/AUTOMATION.md`](docs/AUTOMATION.md) — 설치·업데이트·CI 설명
- [`docs/DASHBOARD.md`](docs/DASHBOARD.md) — GitHub Pages 활성화 + Slack/Discord 알림

---

## 핵심 문서

- [`.agents/product-marketing.md`](.agents/product-marketing.md) — **모든 스킬이 자동으로 참조하는 Dewy 서비스 컨텍스트** (제일 먼저 읽으세요)
- [`references/korean-wedding-market.md`](references/korean-wedding-market.md) — 한국 결혼 시장 도메인 지식 (스드메 구조, 예단, 평균 비용, 경쟁사 등)
- [`references/upstream-skills-map.md`](references/upstream-skills-map.md) — 미커스터마이즈 스킬 매핑
- [`CLAUDE.md`](CLAUDE.md) — Dewy 프로젝트에서 이 스킬셋을 쓰는 규칙

---

## 라이선스

원본 [marketingskills](https://github.com/coreyhaines31/marketingskills) — MIT (Corey Haines)

Dewy 맞춤 수정분 — 동일 MIT.
