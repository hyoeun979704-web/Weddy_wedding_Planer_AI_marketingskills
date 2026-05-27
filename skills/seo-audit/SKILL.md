---
name: seo-audit
description: "Dewy 의 SEO(Naver + Google) 진단·개선. 'SEO', 'SEO 진단', '검색 노출', '네이버 노출', '구글 노출', '키워드', '검색엔진 최적화' 요청에 사용. 한국 시장은 Naver 가 검색 점유율 큰 비중을 차지하므로 Naver SEO 우선, Google 보조. AI 검색 최적화는 ai-seo, 스키마는 schema 참조."
metadata:
  version: 1.0.0
---

# Dewy SEO 진단

웹사이트 https://dewy-wedding.com + 블로그 컨텐츠 의 검색 노출 최적화. **한국 시장은 Naver 와 Google 알고리즘이 매우 다르므로 둘 다 고려**.

---

## 1. Naver vs Google — 핵심 차이

| 항목 | Naver | Google |
|---|---|---|
| 검색 결과 구조 | 통합 검색 (블로그·카페·뉴스·쇼핑·VIEW 탭) | 유기적 결과 + 광고 |
| 우선 노출 | Naver 자체 서비스 (블로그·카페·스마트스토어) | 외부 사이트 동등 |
| 컨텐츠 길이 | 길수록 (1,500–3,000자) | 검색 의도에 따라 다양 |
| 외부 링크 가중치 | 낮음 (자체 생태계 우선) | 매우 높음 |
| 이미지 | 많을수록 가중 (5장+) | 메타데이터 중요 |
| 신선도 | 매우 중요 (최근 글 우선) | 의도에 따라 |
| 모바일 우선 | 모바일 인덱스 분리 | 모바일 우선 인덱스 |

→ **Dewy 가 Naver 노출 받으려면 Naver 블로그 자체에 컨텐츠 발행**. dewy-wedding.com 만 운영하면 Naver 검색에서 거의 안 잡힘.

---

## 2. SEO 진단 7단계

### Step 1: 현재 트래픽 베이스라인

- Google Search Console: 클릭·노출·CTR·평균 순위 (자주 발견 안 된 키워드 확인)
- Naver 서치어드바이저: 사이트 등록·노출 진단
- Vercel Analytics / Supabase 이벤트: 검색 → 가입 전환율

### Step 2: 기술 진단

- robots.txt, sitemap.xml — Naver/Google 둘 다 제출
- 페이지 로딩 (LCP < 2.5s) — 모바일 우선
- 모바일 viewport, 글자 크기, tap target
- canonical 태그 (중복 컨텐츠 방지)
- hreflang 단일 한국어 (영문 없음)
- 구조화 데이터 (`schema` 스킬 참조) — LocalBusiness, FAQPage, Product

### Step 3: 키워드 매핑

페이지마다 단일 타겟 키워드 + 보조 키워드 2—3개. **검색 의도 분류**:
- **Informational** ("결혼준비 체크리스트") → 블로그 컨텐츠
- **Navigational** ("듀이 앱") → 홈 페이지
- **Commercial** ("AI 웨딩 플래너 추천") → 비교 페이지 + 데모
- **Transactional** ("듀이 구독 가격") → 가격 페이지

현재 dewy-wedding.com 구조 점검: 위 4개 의도 각각에 매핑된 페이지 있는지.

### Step 4: 컨텐츠 진단

페이지별 체크:
- 제목 태그: 키워드 포함, 60자 내, 매력 (Naver 는 길어도 60자 권장)
- 메타 설명: 155자 내, CTA 포함
- H1 = 1개 = 페이지 메인 키워드
- H2/H3 구조화
- 본문 길이: 정보 페이지 1,500자+, 가이드 페이지 2,500자+
- 이미지: 5장+, alt 텍스트 한국어, 파일명 한글-영문 자연스럽게
- 내부 링크: 최소 3개 (다른 Dewy 페이지로)
- FAQ 섹션 (`schema` FAQPage)

### Step 5: 백링크 / Naver 외부 인덱스

- Naver 블로그에서 dewy-wedding.com 자연스러운 멘션 (직접 양산 금지)
- 결혼·신혼 카페 (맘이뜰 등) 자연스러운 멘션
- 보도자료 (와이즈리포트, 머니투데이 가족) 출시·펀딩 시점
- 무료 도구 (free-tools) 가 가장 강한 백링크 자석

### Step 6: Naver 특화 컨텐츠

- Naver 블로그 자체 채널 운영 (이웃 추가 받기)
- Naver 카페 자연스러운 참여
- Naver VIEW 탭 노출 → 결혼·신혼 카테고리 블로그 운영

### Step 7: 모니터링

- 주간: 검색 콘솔 클릭 수 추이
- 월간: 키워드별 순위 (Top 50 키워드 트랙)
- 분기: 컨텐츠 갱신 (1년 지난 글 D-Day 식 다시 작성)

---

## 3. Dewy 우선 타겟 키워드 (롱테일)

현재 dewy-wedding.com 이 노릴 만한 키워드:

**정보형**:
- 결혼준비 체크리스트 (검색량 큼)
- 스드메 추천 (의도 명확)
- 결혼 예산 평균 (장문 가이드)
- 결혼 6개월 전 준비 (D-180 가이드)
- 청첩장 모바일 만들기
- 신혼집 인테리어 비용

**브랜드 차별형**:
- AI 웨딩 플래너 (Dewy 가 카테고리 선두 가능)
- 드레스 가상 시연
- 커플 결혼준비 앱

**서울 외 지역 (programmatic SEO 기회)**:
- 부산 웨딩홀 추천 / 대구 스튜디오 / 광주 드레스 / 인천 결혼 식대 — 각 지역마다 페이지

---

## 4. 우선 액션 (출시 3개월)

1. **Naver 서치어드바이저 등록** + sitemap 제출
2. **dewy-wedding.com 에 5개 핵심 가이드 페이지 신설** (체크리스트, 예산, 스드메, AI 활용법, FAQ)
3. **Naver 블로그 채널 개설** + 주 1—2회 발행
4. **schema.org 구조화 데이터** — Organization, WebSite, FAQPage 우선 (스킬 `schema`)
5. **Core Web Vitals** — Vercel 기본 성능 확인, 모바일 LCP/CLS 점검

---

## 5. 측정

- Naver: 서치어드바이저 "수집된 페이지", "검색량·노출량 추이"
- Google: 검색 콘솔 평균 순위, 신규 키워드 발견
- Dewy 자체: SEO 유입 → D-Day 입력 → 가입 전환율

---

## 6. 안티패턴

- ❌ 키워드 스터핑 — 본문에 "결혼준비 결혼준비 결혼준비" 도배. Naver·Google 둘 다 패널티.
- ❌ 가짜 백링크 구매. Naver 가 특히 정교하게 잡음.
- ❌ Google SEO 가이드만 따르면 Naver 무시. 한국 사용자 80% 잃음.
- ❌ 컨텐츠 갱신 안 함. Naver 는 신선도 매우 중요 — 6개월 지난 글 순위 급락.
- ❌ 영어 키워드 노림. "Korean wedding planner" 검색량 매우 작음.

---

## 7. Related Skills

- AI 검색 (Gemini·Perplexity) 노출 → `ai-seo`
- 구조화 데이터 → `schema`
- 페이지 구조 → `site-architecture`
- 양산 페이지 → `programmatic-seo`
- 키워드 → ASO 와 공유 → `aso`
- 컨텐츠 작성 → `content-strategy`, `copywriting`
