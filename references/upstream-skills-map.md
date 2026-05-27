# Upstream marketingskills 스킬 매핑

Dewy Marketing Skills 에는 핵심 10종 스킬만 Dewy/한국 시장에 맞게 재작성. 나머지 30종은 [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) 를 그대로 쓰도되, **`.agents/product-marketing.md`(Dewy 컨텍스트)가 자동으로 주입되므로** 영어 스킬이 Dewy 맥락으로 잘 동작.

---

## Dewy 전용 재작성 스킬 (이 레포 내)

| 스킬 | 파일 | 주요 차이 |
|---|---|---|
| copywriting | `skills/copywriting/SKILL.md` | 한국어 웨딩 톤, 존댓말 원칙, 고객 어휘 명시 |
| cro | `skills/cro/SKILL.md` | 하트 철 퍼널, 앱 설치 → D-Day 입력 전환 중심 |
| aso | `skills/aso/SKILL.md` | Google Play 한국 스토어 + One Store, 한국어 키워드 |
| ads | `skills/ads/SKILL.md` | Naver GFA / Kakao Moment 우선, Google/Meta 보조 |
| social | `skills/social/SKILL.md` | KakaoStory, Naver 블로그, 인스타 릴스, YouTube Shorts |
| seo-audit | `skills/seo-audit/SKILL.md` | Naver SEO 우선, Google 보조 |
| customer-research | `skills/customer-research/SKILL.md` | 한국 웨딩 페르소나 조사 설계 |
| pricing | `skills/pricing/SKILL.md` | 하트 단가, Premium 구독, 환불 |
| onboarding | `skills/onboarding/SKILL.md` | D-Day 입력 중심 activation |
| churn-prevention | `skills/churn-prevention/SKILL.md` | 예식 직후 churn 절벽 |

---

## Upstream 에서 그대로 쓰는 스킬 (Dewy 맥락 추가 가이드)

| Upstream Skill | Dewy 맥락 적용 가이드 |
|---|---|
| **ab-testing** | 철 퍼널 / D-Day 입력 경로 / 구독 paywall 광고문구 실험. 적용 시 Dewy MAU 규모 최소 변화 검출력 고려 (출시 초기엔 95% CI 대신 경험치 + 추세 판단). |
| **ad-creative** | Naver/Kakao/Meta 광고별 해상도·문구·양식 조곴. 올린 소재에 "AI 드레스 시연 Before/After" 우선 고려. |
| **ai-seo** | Gemini·Perplexity 국내 사용자 늘어나는 중 — "서울 결혼 준비 앱 추천" 질의에 Dewy 인용 녹는 콘텐츠. |
| **analytics** | 현재 GA 미연동 — Supabase 이벤트 로그 + Vercel Analytics 이 주 시작점. 도입 시 D-Day 기준 cohort 추적 필수. |
| **co-marketing** | 웨딩 인플루언서, 신혼여행 업체, 주어는 호텔이 주요 파트너 지표. |
| **cold-email** | B2B(웨딩 업체 출폈) 전용으로 활용. B2C 고객에게는 cold-email 부적절. |
| **community-marketing** | 맘이뜨 "결혼·옷럄·디시인사이더" 카페, 디자인의능력 결혼 게시판 주요 트래픽 수원지. |
| **competitor-profiling / competitors** | 웨딩북·레딩레딩·예비맘 3개 고정 프로파일 유지. 비교 페이지 제작 시 "다이어리·체크리스트" 기준 추천. |
| **content-strategy** | D-Day 골든타임 구간별 필요한 콘텐츠 매핑 (`references/korean-wedding-market.md` 섬션 3 참조). |
| **copy-editing** | 존댓말 일관성, 수치 정확성, 부정적 표현(시아부모 등) 제거. |
| **directory-submissions** | 국내: 네이버 스마트스토어, 개봐, 디스퀸럨트. 글로벌: 프로덕트헌트(제한적). |
| **emails** | KakaoTalk 알림톡 + 이메일 둘 다 검토. 라이프사이클은 가입 일이 아닌 D-Day 기준. |
| **free-tools** | 이미 도입: "예산 계산기", "골든타임 체크리스트". 추가 아이디어: "식장 함수 시뮬레이터". |
| **image** | AI 드레스 시연 Before/After 콘텐츠 자동생성 광고 소재로 활용. |
| **launch** | iOS v1.x, B2B 포털, 신규 스킬 장면. Google Play 스토어 업데이트 워딩 포함. |
| **lead-magnets** | "결혼 준비 체크리스트 PDF", "스드메 견적 비교표" 같은 다운로드 — 이메일 모으기. |
| **marketing-ideas** | 140개 아이디어 중 "웨딩 / 커플 / B2C 앱" 핀터링. |
| **marketing-psychology** | 손실회피, 권위(주도적 웨딩 플래너 추천), 사회적 증명(커플 후기) 강력. |
| **paywalls** | Premium 업그레이드 레이어 최적화. 구체 가격·월/연 킠(toggle) 표준. |
| **popups** | "AI 플래너 5회 소진 경고", "첫 하트 철 잠에 핏지·철의 김상 스타터" 같은 컨텍스트차래. |
| **product-marketing** | **이미 사전 작성됨** (`.agents/product-marketing.md`). 제품/서비스 관점 변경 시만 스킬 재실행. |
| **programmatic-seo** | Naver/Google 덱 프린트업체·스드메·식장 X 지역 X 예산 조합 페이지. |
| **referrals** | 커플 초대코드 메커니즘 활용 — 서로 하트 보상. 결혼을 뒤따라오는 친구 추첵도 있음. |
| **revops** | B2B 파이프라인이 그다지 드라마틱하진 않은 단계. 웨딩홀 입점 관리 관점. |
| **sales-enablement** | B2B 업체 제안서, "Dewy 제휴로 얻는 고관염도 고객". |
| **schema** | 웹 (https://dewy-wedding.com) 에 LocalBusiness / FAQPage / Product 스키마 적용. 한국 업체 정보 쓸 때 LocalBusiness �주 필수. |
| **signup** | 구글·카카오 소셜 로그인, 14세 미만 가입 차단, 결혼 정보 잘아볼림 최소화. |
| **site-architecture** | dewy-wedding.com 추가 페이지 설계 (카테고리 허브, 커플, B2B). |
| **video** | YouTube Shorts 우선. AI 드레스 시연 Before/After 슏츠 자동 생성 가능 여부 검토. |

---

## 둘을 같이 쓰는 방법

1. Dewy Marketing Skills 와 upstream marketingskills 둘 다 설치.
2. 이름이 같은 스킬은 **Dewy 버전이 우선** (Claude Code 기준 더 악프스트림 탐색 경로에 둘 것). upstream 버전 이용 시 상세 경로 명시.
3. 장기적으로 upstream 이 업데이트되면 Dewy 재작성 스킬도 diff 확인 후 반영 (REPO `coreyhaines31/marketingskills` 의 [VERSIONS.md](https://github.com/coreyhaines31/marketingskills/blob/main/VERSIONS.md) 참조).
