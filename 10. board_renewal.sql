-- 사용자 테이블 생성
create table author
(id bigint auto_increment, email varchar(50) not null,
name varchar(100), password varchar(255) not null, primary key(id));


-- 주소 테이블 생성
create table address
(id bigint auto_increment, country varchar(255) not null,
 city varchar(255) not null, street varchar(255) not null,
 author_id bigint not null, primary key(id), foreign key(author_id) references author(id));

-- post 테이블 생성
create table post
(id bigint auto_increment, title varchar(255) not null, 
contents varchar(1000), primary key(id));


-- 연결 테이블 생성
create table author_post
(id bigint auto_increment, author_id bigint not null, post_id bigint not null, 
primary key(id),
foreign key(author_id) references author(id), 
foreign key(post_id) references post(id));

-- 복합키를 이용한 연결 테이블 생성
create table author_post2
(id bigint auto_increment, author_id bigint not null, post_id bigint not null, 
primary key(author_id, post_id),
foreign key(author_id) references author(id), 
foreign key(post_id) references post(id));

-- 회원가입 및 주소생성
DELIMITER //
create procedure insert_author(in emailInput varchar(255), in nameInput varchar(255), in passwordInput varchar(255),in countryInput varchar(255), in cityInput varchar(255), in streetInput varchar(255))
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    insert into author(email, name, password) values (emailInput, nameInput, passwordInput);
    insert into address(author_id, country, city, street) values((select id from author order by id desc limit 1) , countryInput, cityInput, streetInput);
    commit;
end //
DELIMITER ;

-- 글쓰기
DELIMITER //
create procedure insert_author(in titleInput varchar(255), in nameInput varchar(255), in passwordInput varchar(255),in countryInput varchar(255), in cityInput varchar(255), in streetInput varchar(255))
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    insert into author(email, name, password) values (emailInput, nameInput, passwordInput);
    insert into address(author_id, country, city, street) values((select id from author order by id desc limit 1) , countryInput, cityInput, streetInput);
    commit;
end //
DELIMITER ;

-- 조회
select p.title as '제목', p.contents as '내용', a.name '이름' from author_post ap inner join author a 
on ap.author_id = a.id
inner join post p
on ap.post_id = p.id;