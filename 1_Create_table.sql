CREATE TABLE issues (
	issue_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '불만ID',
	issue_name TEXT NOT NULL COMMENT '질문 내용',
	course_id INT NOT NULL COMMENT '해당 강좌 ID',
	FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
) COMMENT='강좌별 불만 테이블';