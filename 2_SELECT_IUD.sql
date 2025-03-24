-- SQL 기본 문법
-- 
-- SELECT : 데이터를 조회하는 명령어
-- 
-- INSERT : 데이터를 추가하는 명령어
-- 
-- UPDATE : 수정
-- 
-- DELETE : 삭제

INSERT INTO roles (role_name)
VALUES ("test_role");

SELECT
	role_id,
	role_name
  FROM roles;

-- update

UPDATE 
	roles 
  SET role_name="delete_role"
 WHERE role_id=4; 

-- delete : 
DELETE FROM roles WHERE role_id = 4;

SELECT * FROM roles;
 
-- multi insert
INSERT INTO users(
	username,
	email,
	password_hash,
	role_id)
VALUES ("Jake", "jake@web.email", "hash2323", 1),
("Aly", "aly@web.email", "hash2323", 3);
	

SELECT * FROM users;
  