CREATE DATABASE board
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci; -- 데이터베이스 설정

CREATE USER 'user01'@'localhost' IDENTIFIED BY '1234'; -- 사용자 아이디와 비밀번호 생성

GRANT ALL PRIVILEGES ON board.* TO 'user01'@'localhost';
FLUSH PRIVILEGES; -- 권한 부여

CREATE TABLE members(
	id VARCHAR(50) PRIMARY KEY,           -- 회원 아이디 (고유 키)
    password VARCHAR(200) NOT NULL,       -- 암호화된 비밀번호
    name VARCHAR(100) NOT NULL,           -- 회원 이름
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
















