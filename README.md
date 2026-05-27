# Dewy Marketing Skills

**한국 결혼 시장 특화 AI 웨딩 플래너 [Dewy(듀이)](https://dewy-wedding.com) 를 위한 마케팅 스킬 모음.**

[coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) 의 40개 스킬을 기반으로, Dewy 서비스 컨텍스트(한국 웨딩 시장, 카카오/네이버 생태계, 하트·구독 수익 모델, 커플 동시 사용 등)에 맞춰 재구성했습니다.

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

## 빠른 시작

### 1. 설치

```bash
# Claude Code 플러그인 마켓플레이스로 추가
/plugin marketplace add hyoeun979704-web/weddy_wedding_planer_ai_marketingskills
/plugin install dewy-marketing-skills

# 또는 직접 클론
git clone https://github.com/hyoeun979704-web/weddy_wedding_planer_ai_marketingskills.git
cp -r weddy_wedding_planer_ai_marketingskills/skills/* .agents/skills/
cp weddy_wedding_planer_ai_marketingskills/.agents/product-marketing.md .agents/product-marketing.md
```

### 2. 사용

Dewy 코드베이스 안에서 자연어로 요청하세요:

```
"AI 플래너 첫 사용자 활성화율을 높이고 싶어"
→ /onboarding 스킬 호출 (Dewy 의 D-Day 역산 골든타임 활용)

"카카오모먼트 광고 카피 5개 만들어줘"
→ /ads 스킬 (Naver/Kakao 우선 매핑)

"Premium 구독 paywall 카피 다듬자"
→ /paywalls + /copywriting (한국 웨딩 톤)

"네이버 검색 노출 늘리는 방안"
→ /seo-audit (Naver SEO 가이드)
```

---

## 포함된 스킬 (Dewy 맞춤)

| 스킬 | 핵심 차이 |
|---|---|
| [copywriting](skills/copywriting/) | 한국 웨딩 톤, 존댓말/반말, 신랑·신부 호칭, 스드메 용어 |
| [aso](skills/aso/) | Google Play 한국 / One Store, 한국어 키워드(웨딩, 결혼준비, 예단 등) |
| [ads](skills/ads/) | Naver GFA / 카카오모먼트 우선, Google·Meta 보조 |
| [social](skills/social/) | 인스타 릴스, 네이버 블로그, KakaoStory, 카카오 채널 |
| [customer-research](skills/customer-research/) | 한국 예비부부 페르소나 (D-Day 기반), 부모 페르소나 |
| [pricing](skills/pricing/) | 하트 단가, Premium 월/연 구독, 환불 정책 |
| [onboarding](skills/onboarding/) | D-Day 입력 → 골든타임 추천, AI 플래너 첫 사용 |
| [churn-prevention](skills/churn-prevention/) | 예식 직후 churn 절벽, 신혼부부 LTV 연장 |
| [cro](skills/cro/) | 하트 충전·구독 전환 퍼널, 커플 연동 활성화 |
| [seo-audit](skills/seo-audit/) | Naver SEO + Google 듀얼, 한국 결혼 키워드 클러스터 |

나머지 30개 스킬은 [references/upstream-skills-map.md](references/upstream-skills-map.md) 에서 upstream marketingskills 와 Dewy 활용 가이드를 매핑해 두었습니다.

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
