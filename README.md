# 🎵 Kotonoha-Uta (言の葉歌)
> **J-POP 가사와 AI를 결합한 지능형 일본어 학습 플랫폼**
**상업용 목적이 전혀 없음을 밝힙니다.**
유튜브 음악을 감상하며 실시간 가사를 확인하고, Google Gemini AI를 통해 문법과 문화를 깊이 있게 학습할 수 있는 Flutter 앱입니다.

---

## 🚀 핵심 기능 (Core Features)

* **지능형 가사 분석 (AI Analysis)**: Gemini API를 연동하여 가사 속 복잡한 문법과 문맥을 분석하여 학습자에게 제공합니다.
* **효율적인 데이터 캐싱 (Caching System)**: 동일한 곡에 대한 중복 AI 분석을 방지하여 응답 속도를 높이고 API 비용을 최적화했습니다. [cite: 2026-01-22]
* **직관적인 학습 UI**: `ruby_text` 패키지를 활용해 한자와 후리가나를 명확히 구분하여 가독성을 극대화했습니다.
* **로컬 데이터베이스 관리**: `Drift`를 사용하여 학습 기록과 가사 데이터를 안정적으로 관리하며 오프라인 환경에서도 데이터 접근이 가능합니다.

---

## 🛠 기술 스택 (Tech Stack)

| 분류 | 기술 |
| :--- | :--- |
| **Framework** | Flutter (Dart) |
| **AI Engine** | Google Generative AI (Gemini) |
| **Database** | Drift (SQLite) |
| **API / Media** | YouTube API, LrcLib |
| **Architecture** | Provider / Flutter Hooks |

---

## 💡 기술적 고민과 해결 (Engineering Challenges)

### 1. 성능 및 비용 최적화 (Performance & Cost Optimization)
* **문제**: 가사 분석 시마다 API를 호출하여 불필요한 비용이 발생하고 네트워크 대기 시간으로 인한 사용자 경험 저하.
* **해결**: 데이터베이스 기반의 **캐싱 로직**을 구현했습니다. 이미 분석된 데이터는 API 호출 없이 DB에서 즉시 로드되어 성능과 비용 효율성을 동시에 잡았습니다.

### 2. 유지보수 및 확장성 고려 (Maintainability)
* **문제**: AI가 원곡의 제목과 가수명을 제대로 분석하지 못해, 유튜브 제목에 섞인 노이즈(예: [MV], Official, | 대파 등)로 인해 가사 검색 엔진의 정확도 저하.
* **해결**: 사용자가 직접 입력하는 위젯을 추가하여 정확도를 상승시켰으며, 파싱이 실패할 경우를 대비해 LrcLib와 Netease 2곳의 http로 원곡 가사를 2차 파싱하도록 구현.

---

## 📂 프로젝트 구조 (Project Architecture)

```text
lib/
├── database/     # Drift DB 스키마 정의 및 데이터 접근 로직
├── models/       # 불변성(Immutable)을 유지한 데이터 모델 정의
├── screens/      # 가사 상세, 검색 등 UI 페이지 레이어
├── service/      # Gemini 분석 및 가사 검색(Fetch) 로직 서비스
└── utils/        # 제목 파싱 등 공통 유틸리티 클래스
