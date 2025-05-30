-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
create user 'yoon'@'%' identified by '4321';

-- 사용자에게 권한부여
grant select on board.author to 'yoon'@'%'
grant select, insert on board.* to 'yoon'@'%';
grant all privileges on board.* to 'yoon'@'%';

-- 사용자 권한 회수
revoke select on board.author from 'yoon'@'%';

-- 사용자 권한 조회
show grants for 'yoon'@'%';

-- 사용자 계정삭제
drop user 'yoon'@'%';