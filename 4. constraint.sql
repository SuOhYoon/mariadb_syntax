-- not null 제약조건 추가
alter table author modfiy column name varchar(255) not null;
-- not null 제약조건 제거
alter table author modfiy column name varchar(255);
-- not null, unique 제약조건 동시추가
alter table author modify column email varchar(255) not null unique;

-- 태아불 차원의 제약조건(pk, fk) 추가/제거
-- 제약조건 삭제
alter table post drop foreign key 제약조건명;
alter table post drop constraint 제약조건명;
-- 제약조건 삭제(pk)
alter table post drop primary key;
-- 제약조건 추가
alter table post add constraint post_pk primary key;
alter table post add constraint post_fk foreign key(author_id) references author(id);

-- on delete/update 제약조건 테스트
-- 부모테이블 데이터 delete시에 자식 fk컬럼 set null, updatet시에 자식 fk컬럼 cascade
alter table post add constraint post_fk_new foreign key(author_id) references author(id) on delete set null on update cascade;

-- default 옵션
-- enum 타입 및 현재시간(current_timestamp)에서 많이 사용
alter table author modify column name varchar(255) default 'anonymous';
-- auto_increment : 입력을 안했을때 마지막애 입력된 가장 큰값에서 +1만큼 자동으로 증가된 숫자값을 적용
alter table author modify column bigint id auto_increment;
alter table post modify column bigint id auto_increment;

-- uuid 타입
alter table post add column user_id char(36) default (uuid());
