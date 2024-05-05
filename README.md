## Work out - 운동 도우미 웹 애플리케이션

<aside>
💡 Workout은 운동을 좋아하는 사람, 배우고 싶은 사람 여러사람이 모여 정보를 공유할 수 있는 플랫폼 입니다. 다이어트가 목적인 사람을 위한 Flexible Diet 를 도울 수 있도록 베네딕트 해리스 방정식을 활용한 기초대사량을 구해주며 점진적으로 칼로리를 조절할 수 있도록 주차별 칼로리 및 탄단지를 설정해줍니다. 식품안전나라 API를 활용하여 섭취한 음식을 기록하고 구체적인 칼로리 및 영양소를 추적할 수 있어 다이어트에 큰 도움을 줍니다. 또한 Teachable Machine을 통해 구현한 인공지능 동작인식 기능은 스쿼트, 푸쉬업의 자세를 교정해줍니다.

</aside>

## 1. 기술스택


### Backend

- maven project
- spring 4.x
- java 11
- MariaDB
- Redis
- JSP
- MyBatis

### Infra

- AWS
    - EC2
    - RDS
    - Route53

### ETC

- TeachableMachine
- IntelliJ
- Notion
- 식품정보 API

## 2. 구현내용 요약

- Bootstrap5를 활용해 전체적인 페이지 개발
- Teacherable Machine을 활용하여 동작 인식 후 개수카운트 기능
- Redis를 이용한 최근검색어 기능구현
- 식품안전나라 식품영양정보 API를 활용한 식단기록 기능 개발
- 회원정보 및 마이페이지, 운동정보, 식단정보 게시판 CRUD 개발
- AWS 인프라 구성, 배포, 운영
- 테이블 구조 설계
