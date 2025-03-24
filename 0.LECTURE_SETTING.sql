-- 아래의 내용을 가정하고 진행함.
-- 결제 상태는 따로 관리하지 않음.
-- 권한은 1개만 갖음.
-- 질문에 답변은 한번만 가능.

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS quiz_questions;
DROP TABLE IF EXISTS quiz_attempts;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS lessons;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

-- 역할 테이블
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '역할 ID (고유 식별자)',
    role_name VARCHAR(50) UNIQUE NOT NULL COMMENT '사용자 역할 (Admin, Instructor, Student)'
) COMMENT='사용자의 역할을 정의하는 테이블';

-- 사용자 테이블
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '사용자 ID (고유 식별자)',
    username VARCHAR(100) NOT NULL COMMENT '사용자 이름',
    email VARCHAR(100) UNIQUE NOT NULL COMMENT '이메일 (고유 값)',
    password_hash VARCHAR(255) NOT NULL COMMENT '비밀번호 해시값',
    role_id INT NOT NULL COMMENT '사용자 역할 ID (외래키)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '계정 생성일',
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE
) COMMENT='LMS 시스템의 사용자 정보를 저장하는 테이블';

-- 강좌 테이블 (Instructor만 개설 가능)
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '강좌 ID (고유 식별자)',
    title VARCHAR(255) NOT NULL COMMENT '강좌 제목',
    description TEXT COMMENT '강좌 설명',
    instructor_id INT NOT NULL COMMENT '강좌 담당 강사 ID (외래키)',
    price DECIMAL(10,2) DEFAULT 0 CHECK (price >= 0) COMMENT '강좌 가격',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '강좌 생성일',
    FOREIGN KEY (instructor_id) REFERENCES users(user_id) ON DELETE CASCADE
) COMMENT='강좌 정보를 저장하는 테이블';

-- 수강 신청 (학생만 가능)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '수강 신청 ID (고유 식별자)',
    user_id INT NOT NULL COMMENT '수강하는 학생 ID (외래키)',
    course_id INT NOT NULL COMMENT '수강 강좌 ID (외래키)',
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '수강 신청일',
    status ENUM('active', 'completed', 'canceled') DEFAULT 'active' COMMENT '수강 상태',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) COMMENT='학생의 수강 신청 정보를 저장하는 테이블';

-- 강의 테이블
CREATE TABLE lessons (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '강의 ID (고유 식별자)',
    course_id INT NOT NULL COMMENT '소속 강좌 ID (외래키)',
    title VARCHAR(255) NOT NULL COMMENT '강의 제목',
    content TEXT COMMENT '강의 내용',
    video_url VARCHAR(500) DEFAULT NULL COMMENT '강의 비디오 URL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '강의 생성일',
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) COMMENT='각 강좌의 개별 강의 정보를 저장하는 테이블';

-- 과제 테이블
CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '과제 ID (고유 식별자)',
    lesson_id INT NOT NULL COMMENT '소속 강의 ID (외래키)',
    title VARCHAR(255) NOT NULL COMMENT '과제 제목',
    description TEXT COMMENT '과제 설명',
    due_date DATE COMMENT '과제 마감일',
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE
) COMMENT='강의에 대한 과제 정보를 저장하는 테이블';

-- 퀴즈 테이블
CREATE TABLE quizzes (
    quiz_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '퀴즈 ID (고유 식별자)',
    course_id INT NOT NULL COMMENT '소속 강좌 ID (외래키)',
    title VARCHAR(255) NOT NULL COMMENT '퀴즈 제목',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '퀴즈 생성일',
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) COMMENT='강좌별 퀴즈 정보를 저장하는 테이블';

-- 퀴즈 질문 테이블 (TEXT 대신 VARCHAR(255) 적용)
CREATE TABLE quiz_questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '퀴즈 질문 ID (고유 식별자)',
    quiz_id INT NOT NULL COMMENT '소속 퀴즈 ID (외래키)',
    question_text TEXT NOT NULL COMMENT '퀴즈 질문 내용',
    question_type ENUM('multiple_choice', 'true_false', 'short_answer') NOT NULL COMMENT '질문 유형',
    correct_answer VARCHAR(255) NOT NULL COMMENT '정답 (긴 답변은 별도 테이블로 관리 가능)',
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
) COMMENT='퀴즈의 개별 질문 정보를 저장하는 테이블';

-- 퀴즈 시도 테이블
CREATE TABLE quiz_attempts (
    attempt_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '퀴즈 응시 기록 ID (고유 식별자)',
    user_id INT NOT NULL COMMENT '응시 학생 ID (외래키)',
    quiz_id INT NOT NULL COMMENT '응시한 퀴즈 ID (외래키)',
    score DECIMAL(5,2) DEFAULT 0 COMMENT '획득 점수',
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '퀴즈 응시 날짜',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
) COMMENT='학생의 퀴즈 응시 기록을 저장하는 테이블';

-- 결제 테이블 (음수 결제 방지)
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '결제 ID (고유 식별자)',
    user_id INT NOT NULL COMMENT '결제한 학생 ID (외래키)',
    course_id INT NOT NULL COMMENT '결제된 강좌 ID (외래키)',
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0) COMMENT '결제 금액',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '결제일',
    payment_status ENUM('pending', 'completed', 'failed') DEFAULT 'pending' COMMENT '결제 상태',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) COMMENT='강좌 결제 내역을 저장하는 테이블';

-- 성적 테이블 (자동 상태 업데이트)
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '성적 ID (고유 식별자)',
    user_id INT NOT NULL COMMENT '학생 ID (외래키)',
    course_id INT NOT NULL COMMENT '강좌 ID (외래키)',
    final_score DECIMAL(5,2) DEFAULT NULL COMMENT '최종 점수',
    status ENUM('passed', 'failed', 'in_progress') DEFAULT 'in_progress' COMMENT '수강 상태',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) COMMENT='학생의 성적 정보를 저장하는 테이블';
