CREATE DATABASE board
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci; -- 데이터베이스 설정

CREATE USER 'user01'@'localhost' IDENTIFIED BY '1234'; -- 사용자 아이디와 비밀번호 생성

GRANT ALL PRIVILEGES ON board.* TO 'user01'@'localhost';
FLUSH PRIVILEGES; -- 권한 부여

CREATE TABLE members(
	id VARCHAR(50) PRIMARY KEY,           -- 회원 아이디 (고유 키)
    password VARCHAR(200) NOT NULL,       -- 암호화된 비밀번호
    name VARCHAR(100) NOT NULL unique,           -- 회원 이름
    email VARCHAR(200) NOT NULL,          -- 이메일
    role VARCHAR(20) DEFAULT 'MEMBER',    -- 권한 (MEMBER 또는 ADMIN)
    phone VARCHAR(20),                    -- 전화번호 (선택)
    regdate TIMESTAMP DEFAULT NOW(),      -- 가입일시 (자동 입력)
    enabled BOOLEAN DEFAULT TRUE          -- 계정 활성화 여부
);

CREATE TABLE member_roles (
    id VARCHAR(50) NOT NULL,              -- 회원 아이디
    role VARCHAR(50) NOT NULL,            -- 권한 이름
    PRIMARY KEY (id, role),               -- 복합 키 (둘 다 합쳐서 고유)
    
    CONSTRAINT fk_roles_members
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE 	-- 외래키 제약조건.
);


CREATE TABLE board (
    seq INT AUTO_INCREMENT PRIMARY KEY,   -- 글 번호 (자동 증가)
    writer VARCHAR(50) NOT NULL,          -- 작성자 아이디
    title VARCHAR(500) NOT NULL,          -- 글 제목
    content TEXT NOT NULL,                -- 글 내용
    hit INT DEFAULT 0,                    -- 조회수
    regdate TIMESTAMP DEFAULT NOW(),      -- 작성일시
    updatedate TIMESTAMP DEFAULT NOW()    -- 수정일시
        ON UPDATE CURRENT_TIMESTAMP,
    delflag BOOLEAN DEFAULT FALSE,        -- 삭제 여부 (논리적 삭제)
    
    CONSTRAINT fk_board_members
    FOREIGN KEY (writer) REFERENCES members(id) ON DELETE CASCADE
);

CREATE TABLE reply (
    rno INT AUTO_INCREMENT PRIMARY KEY,   -- 댓글 번호 (자동 증가)
    bno INT NOT NULL,                      -- 게시글 번호 (외래키)
    replyText VARCHAR(500) NOT NULL,      -- 댓글 내용
    replyer VARCHAR(50) NOT NULL,         -- 댓글 작성자 아이디
    replydate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 댓글 작성일시
    updatedate TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 댓글 수정일시
        ON UPDATE CURRENT_TIMESTAMP,
    delflag BOOLEAN DEFAULT FALSE,         -- 삭제 여부 (논리적 삭제)
    
    CONSTRAINT fk_reply_board
    FOREIGN KEY (bno) REFERENCES board(seq) ON DELETE CASCADE
);

select * from members;
select * from board;
select * from reply;

insert into reply (bno, replyText, replyer)
select 401, replyText, replyer from reply where bno = 401;

INSERT INTO board (title, content, writer, regDate, delflag)
SELECT title, content, writer, NOW(), delflag 
FROM board;

INSERT INTO members (id, password, name, email, role, phone) VALUES 
('coding_king', '1234', '박코딩', 'king@dev.com', 'MEMBER', '010-1111-0001'),
('coffee_holic', '1234', '이카페', 'coffee@test.com', 'MEMBER', '010-1111-0002'),
('gym_rat', '1234', '김근육', 'muscle@health.com', 'MEMBER', '010-1111-0003'),
('movie_fan', '1234', '최무비', 'cinema@movie.com', 'MEMBER', '010-1111-0004'),
('traveler_99', '1234', '정여행', 'world@travel.com', 'MEMBER', '010-1111-0005'),
('food_finder', '1234', '마슐랭', 'delicious@food.com', 'MEMBER', '010-1111-0006'),
('night_owl', '1234', '한밤중', 'darkness@sleep.com', 'MEMBER', '010-1111-0007'),
('dreamer_7', '1234', '유미래', 'future@dream.com', 'MEMBER', '010-1111-0008'),
('lucky_strike', '1234', '복권당', 'win@money.com', 'MEMBER', '010-1111-0009'),
('spring_lover', '1234', '오봄이', 'spring@flower.com', 'MEMBER', '010-1111-0010');

INSERT INTO members (id, password, name, email, role, phone) VALUES 
('user01', '1234', '홍길동', 'user01@test.com', 'MEMBER', '010-1111-0001'),
('user02', '1234', '김철수', 'user02@test.com', 'MEMBER', '010-1111-0002'),
('user03', '1234', '이영희', 'user03@test.com', 'MEMBER', '010-1111-0003'),
('user04', '1234', '박지성', 'user04@test.com', 'MEMBER', '010-1111-0004'),
('user05', '1234', '손흥민', 'user05@test.com', 'MEMBER', '010-1111-0005'),
('user06', '1234', '김연아', 'user06@test.com', 'MEMBER', '010-1111-0006'),
('user07', '1234', '봉준호', 'user07@test.com', 'MEMBER', '010-1111-0007'),
('user08', '1234', '조수미', 'user08@test.com', 'MEMBER', '010-1111-0008'),
('user09', '1234', '이강인', 'user09@test.com', 'MEMBER', '010-1111-0009'),
('user10', '1234', '황희찬', 'user10@test.com', 'MEMBER', '010-1111-0010');

INSERT INTO board (writer, title, content, regdate) VALUES 
('coding_king', '오늘도 에러와 싸우는 중...', 'StackOverflow는 나의 구원자입니다.', NOW()),
('coffee_holic', '에스프레소 추출 꿀팁 공유합니다', '분쇄도가 제일 중요하다는 사실, 알고 계셨나요?', NOW()),
('gym_rat', '오운완! 오늘 등 운동 루틴', '데드리프트 100kg 찍었습니다. 뿌듯하네요.', NOW()),
('movie_fan', '최신 개봉작 관람평 (스포주의)', '영상미는 좋은데 스토리가 조금 아쉽네요.', NOW()),
('traveler_99', '제주도 한 달 살기 후기', '바다 냄새 맡으며 일하는 기분은 최고입니다.', NOW()),
('food_finder', '역대급 돈까스 맛집 발견했습니다', '웨이팅 1시간 했지만 후회 없는 맛이었어요.', NOW()),
('night_owl', '새벽 3시, 잠이 안 올 때 듣는 노래', '몽환적인 분위기의 플레이리스트 공유합니다.', NOW()),
('dreamer_7', '10년 후의 나에게 쓰는 편지', '그때는 조금 더 멋진 사람이 되어있기를.', NOW()),
('lucky_strike', '이번 주 로또 번호 추천 받습니다', '꿈에 조상님이 나타나셨거든요. 제발!', NOW()),
('spring_lover', '벚꽃 엔딩, 내년에 다시 만나자', '올해 꽃구경은 이걸로 끝이네요. 아쉽습니다.', NOW());

INSERT INTO board (writer, title, content, regdate) VALUES 
('user01', '안녕하세요, 홍길동입니다.', '반갑습니다. 첫 게시글을 작성해 봅니다!', NOW()),
('user02', '철수의 일기', '오늘은 자바 공부를 열심히 했다. 페이징이 어렵다.', NOW()),
('user03', '영희의 추천 맛집', '동네에 새로 생긴 파스타집 정말 맛있어요!', NOW()),
('user04', '지성팍의 축구 교실', '기본기가 가장 중요하다는 걸 잊지 마세요.', NOW()),
('user05', '손흥민의 경기 후기', '팬 여러분의 응원 덕분에 이길 수 있었습니다!', NOW()),
('user06', '은반 위의 요정', '오늘 훈련도 무사히 마쳤습니다. 링크장이 춥네요.', NOW()),
('user07', '기생충 비하인드 스토리', '계단이라는 공간이 주는 의미에 대해...', NOW()),
('user08', '밤의 여왕 아리아 연습 중', '목 관리가 제일 힘드네요. 따뜻한 차 한 잔.', NOW()),
('user09', '파리에서 온 편지', '여기 날씨는 참 좋네요. 축구하기 딱 좋습니다.', NOW()),
('user10', '황소의 돌파력 비결', '웨이트 트레이닝 루틴 공유해 드립니다.', NOW());

INSERT INTO reply (bno, replyText, replyer) VALUES
(401, '이거 코드 로직이 예술이네요. 역시 개발은 예술입니다.', 'coding_king'),
(401, '카페인 수혈하면서 읽고 있는데 정신이 번쩍 드는 글이네요 ☕', 'coffee_holic'),
(401, '오운완 하고 읽으러 왔습니다. 글에서도 근육의 향기가 나네요.', 'gym_rat'),
(401, '영화 한 편 본 것 같은 몰입감이네요. 대박입니다.', 'movie_fan'),
(401, '다음 여행지는 이 글로 정했습니다. (진지)', 'traveler_99'),
(401, '맛집 정보인 줄 알고 들어왔는데 지식 맛집이었군요?', 'food_finder'),
(401, '모두가 잠든 밤, 혼자 읽기 아까운 명문입니다.', 'night_owl'),
(401, '제 미래를 바꿀 힌트를 여기서 얻어갑니다. 감사합니다.', 'dreamer_7'),
(401, '오늘 운세가 좋더니 이런 꿀정보를 다 보네요 🍀', 'lucky_strike'),
(401, '봄바람처럼 마음이 설레는 유익한 정보네요 ㅎㅎ', 'spring_lover'),
(401, '홍길동이 추천합니다. 동에 번쩍 서에 번쩍 하며 봐도 최고네요.', 'user01'),
(401, '철수도 인정하는 바입니다. 영희야 너도 이거 봐라.', 'user02'),
(401, '영희가 보고 왔어요. 철수야 너나 잘해 ^^', 'user03'),
(401, '산소탱크처럼 지치지 않고 끝까지 읽었습니다.', 'user04'),
(401, '월클 수준의 통찰력이네요. 골 넣은 것보다 짜릿합니다!', 'user05'),
(401, '은반 위의 연기처럼 부드럽고 완벽한 문장이에요.', 'user06'),
(401, '이 글은 계획이 다 있군요? 기생충급 반전입니다.', 'user07'),
(401, '천상의 목소리처럼 가슴에 울림을 주는 글입니다.', 'user08'),
(401, '막내의 패기로 댓글 남깁니다. 진짜 유익해요!', 'user09'),
(401, '황소처럼 밀어붙이는 전개가 아주 인상적입니다.', 'user10');

INSERT INTO reply (bno, replyText, replyer) VALUES
(400, '400번 게시글 달성을 축하드립니다! 내용도 아주 알차네요.', 'coding_king'),
(400, '글을 읽다 보니 따뜻한 아메리카노가 생각나는 아침입니다.', 'coffee_holic'),
(400, '정신 수양에 큰 도움이 되는 글이네요. 잘 읽고 갑니다.', 'gym_rat'),
(400, '기승전결이 완벽한 시나리오를 보는 듯한 느낌입니다.', 'movie_fan'),
(400, '이 글을 보니 당장이라도 배낭 싸서 떠나고 싶어지네요.', 'traveler_99'),
(400, '내용이 아주 쫄깃쫄깃한 게 맛집 탐방하는 기분이에요.', 'food_finder'),
(400, '다들 잠든 새벽에 혼자 깨서 보기엔 너무 아까운 글입니다.', 'night_owl'),
(400, '우리의 미래가 이 글처럼 밝았으면 좋겠습니다.', 'dreamer_7'),
(400, '오늘 이 글을 읽은 게 저에겐 가장 큰 행운입니다.', 'lucky_strike'),
(401, '꽃피는 봄이 오면 다시 한번 정독하러 오겠습니다.', 'spring_lover'),
(400, '동에 번쩍 서에 번쩍 하며 봐도 이만한 글이 없군요!', 'user01'),
(400, '철수도 이 글을 읽고 감동의 눈물을 흘렸습니다.', 'user02'),
(400, '철수야, 넌 이런 글 좀 보고 배워라. 그치 영희야?', 'user03'),
(400, '끝까지 읽었는데도 숨이 차지 않을 만큼 몰입감이 최고네요.', 'user04'),
(400, '이런 퀄리티의 글은 정말 월드클래스라고 봅니다.', 'user05'),
(400, '빙판 위의 연기처럼 군더더기 없이 깔끔한 글입니다.', 'user06'),
(400, '글 속에 복선이 아주 잘 깔려 있네요. 거장답습니다.', 'user07'),
(400, '글의 선율이 마치 오페라 한 장면처럼 아름답네요.', 'user08'),
(400, '막내답게 힘차게 응원 댓글 남기고 갑니다! 파이팅!', 'user09'),
(400, '저돌적인 문체에 압도당했습니다. 황소 같은 추진력이네요.', 'user10');

INSERT INTO reply (bno, replyText, replyer) VALUES
(399, '399번이라니.. 400번 고지가 바로 앞이군요!', 'coding_king'),
(399, '글 한 모금에 힐링 한 모금 하고 갑니다.', 'coffee_holic'),
(399, '멘탈 근육을 키워주는 아주 단단한 글이네요.', 'gym_rat'),
(399, '이건 무조건 10점 만점에 10점 드립니다.', 'movie_fan'),
(399, '세상은 넓고 좋은 글은 정말 많네요.', 'traveler_99'),
(399, '글의 풍미가 남다릅니다. 깊은 맛이 나네요.', 'food_finder'),
(399, '밤이 깊어갈수록 글의 깊이도 더해지네요.', 'night_owl'),
(399, '꿈을 꾸는 사람들에게 지침서 같은 글입니다.', 'dreamer_7'),
(399, '로또 1등 당첨된 기분이에요. 감사합니다!', 'lucky_strike'),
(399, '봄기운 가득 담아 응원 댓글 남깁니다~', 'spring_lover'),
(399, '도술을 부린 것마냥 글 속에 푹 빠졌습니다.', 'user01'),
(399, '오늘부터 제 인생 글 1위로 저장합니다.', 'user02'),
(399, '영희도 추천 박고 갑니다! 쾅쾅!', 'user03'),
(399, '90분 내내 읽어도 지루하지 않을 글이에요.', 'user04'),
(399, '진짜가 나타났네요. 프리미어리그급 필력입니다.', 'user05'),
(399, '완벽한 회전 끝에 착지한 기분이네요. 최고!', 'user06'),
(399, '이 글 자체가 하나의 훌륭한 작품입니다.', 'user07'),
(399, '천상의 울림 같은 감동적인 글이었습니다.', 'user08'),
(399, '패스만큼 깔끔한 문장에 감탄하고 갑니다.', 'user09'),
(399, '멈추지 않는 공격수처럼 강렬한 인상을 받았어요.', 'user10');






-- 초기화
SET FOREIGN_KEY_CHECKS = 0;

truncate table reply;
truncate table board;
truncate table members;

SET FOREIGN_KEY_CHECKS = 1;







