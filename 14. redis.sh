# redis 접속
redis-cli

# redis 접속(docker)
docker exec-it 컨테이너id redis-cli

# db 선택
select db번호

# 데이터베이스내 모든 키 조회
keys *

# 일반적인 String 자료구조
# set을 통해 key:value 세팅.
set user1 hong@naver.com
set user:email:1 hong1@naver.com
set user:email:2 "hong2@naver.com"
# 기존에 key:value값이 존재할 경우 덮어쓰기
set user:email:1 hong3@naver.com
# key값이 이미 존재하면 pass, 없으면 set : nx
set user:email:1 hon4@naver.com
# 만료시간(ttl) 설정(초단위) : ex
set user:email:5 hong5@naver.com ex 10
# redis 실전활용 : token등 사용자 인증정보 저장 -> 빠른성능활용
set user:1:refresh_token abcdefg1234 ex 1800

# key로 통해 value get
get user1
# 특정 key삭제
del user1
# 현재 DB내 모든 key값 삭제
flushdb

# redis실전활용 : 좋아요기능 구현 -> 동시성이슈 해결
set likes:posting:1 abc #redis는 기본적으로 모든 key:value가 문자열. 내부적으로는 "0"으로
incr likes:posting:1 #특정 key값의 value를 1증가
decr likes:posting:1 #특정 key값의 value를 1감소
# redis 실전활용 : 재고관리 구현 -> 동시성 이슈 해결
set stocks:product:1 100
decr stocks:product:1
incr stocks:product:1

# redis 실전활용 : 캐싱기능구현
# 1번 회원 정보 조회 : select name, email, age from member where id = 1;
# 위 데이터의 결과값을 spring서버를 통해 json으로 변형하여, redis 캐싱
# 최종적인 데이터 형식 : {"name":"hong", "email":"hong@daum.net", "age":30}
set member:info:1 "{\"name\":\"hong\", \"email\":\"hong@daum.net\", \"age\":30}" ex 1000

# list 자료구조
# redis의 list는 deque와 같은 자료구조. 즉 double-ended queue 구조
# lpush : 데이터를 list자료구조에 왼쪽부터 삽입
# rpush : 데이터를 list자료구조에 오른쪽부터 삽입
lpush hongs hong1
lpush hongs hong2
rpush hongs hong3
# list 조회 : 0은 리스트의 시작인덱스를 의미. -1은 리스트의 마지막인덱스를 의미
1range hongs 0 -1 # 전체조회
1range hongs -1 -1 # 마지막 값 조회
1range hongs 0 0 #0번째 값 조회
1range hongs -2 -1 #마지막2번째부터 마지막까지
1range hongs 0 2 #0번째부터 2번쨰까지
# list값 꺼내기. 꺼내면서 삭제.
rpop hongs
lpop hongs  
# A리스트에서 rpop하여 B리스트에서 lpush
rpoplpush A리스트 B리스트
rpush abc a2
rpush bcd b1
rpush bcd b2
rpoplpush abc bcd
# list의 데이터 개수 조회
llen hongs
# ttl 적용
expire hongs 20
# ttl 조회
ttl hongs
# redis실전활용 : 최근 조회한 상품 목록
rpush user:1:recent:product apple
rpush user:1:recent:product banana
rpush user:1:recent:product orange
rpush user:1:recent:product melon
rpush user:1:recent:product mango
# 최근본상품3개조회
1range user:1:recent:product -3 -1

# set자료구조 : 중복없음, 순서없음.
sadd memberlist m1
sadd memberlist m2
sadd memberlist m3
# set 조회
smembers memberlist
# set멤버 개수 조회
scard memberlist
# 특정멤버가 set안에 있는 존재여부 확인
sismember memberlist m2

# redis실전활용 : 좋아요 구현
# 게시글 상세보기에 들어가면
scard posting:likes:1
sismember posting:likes:1 a1@naver.com
# 게시글에 좋아요를 하면
sadd posting:likes:1 a1@naver.com
# 좋아요한사람을 클릭하면
smembers posting:likes:1

#zset : g