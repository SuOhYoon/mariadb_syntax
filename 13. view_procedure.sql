-- view : 실제데이터를 참조만 하는 가상의 테이블. SELECT만 가능
-- 사용목적 : 1) 복잡한 쿼리를 사전생성 2) 권한 분리

-- view 생성
create view author_for_view as select name, email form author;

-- view 조회
select * from author_for_view;

-- view 권한 부여
grant select on board.author_for_view to '계정명'@'%';

-- view 삭제
drop view author_for_view;

-- 프로시저
delimiter //
create procedure hello_procedure()
begin

end
// delimiter ;

-- 프로시저 호출
call hello_procedure();

-- 프로시저 삭제
drop hello_procedure();

-- 회원목록 조회 : 한글명 프로시저 가능
delimiter //
create procedure 회원목록조회()
begin
    select * from author;
end
// delimiter ;

-- 회원상세 조횐 : input값 사용 가능
delimiter //
create procedure 회원목록조회(in emailInput varchar(255))
begin
    select * from author;
end
// delimiter ;

-- 글쓰기
delimiter //
create procedure 글쓰기(in titleInput varchar(255), in contentInput varchar(255), in emailInput varchar(255))
begin
-- declare는 begin밑에 위치
    declare exit handler for SQLEXCEPTION
    declare authorIdInput bigint;
    declare postIdInput bigint;
    begin
        rollback;
    end;
    start transaction;
        select id into authorIdInput from author where email = emailInput;
        insert into post(title, contents) values(titleInput, contentInput);
        select id into postIdInput from post order by id desc limit 1;
        insert into author_post(author_id, post_id) values();
    commit;
end
// delimiter ;

-- 여러명이 편집가능한 글에서 글삭제
delimiter //
create procedure 글삭제(in postIdInput bigint, int emailInput varchar(255))
begin
    select count(*) into authorPostCount from author_post where post_id = postIdInput;
    select id into authorId from author where email = emailInput;
    -- 글쓴이가 나밖에 없는경우 : author_post 삭제, post까지 삭제
    -- 글쓴이가 나 이외에 다른사람도 있는 경우 : author_post만 삭제
    if authorPostCount=1 THEN
-- elseif도 사용 가능
        delete from authot_post where author_id = authorId and post_id = postIdInput;
        delete from post where id=postIdInput;
    else
        delete from author_post where author_id = authorId; 
    end if;
end
// delimiter ;

-- 반복문을 통한 post 대량생성
create procedure 대량글쓰기(in countInput bigint), in emailInput varchar(255))
begin
-- declare는 begin밑에 위치
    declare authorIdInput bigint;
    declare postIdInput bigint;
    declare countValue bigint default 0;
    declare 
        while countValue < countInput do
            select id into authorIdInput from author where email = emailInput;
            insert into post(title) values("안녕하세요");
            select id into postIdInput from post order by id desc limit 1;
            insert into author_post(author_id, post_id) values(authorIdInput, postIdInput);
            set countValue = countValue+1;
        end while;
end
// delimiter ;