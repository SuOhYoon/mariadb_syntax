# 덤프파일 생성
mysqldump -u root -p 스키마명 > 덤프파일명
mysqldump -u root -p board > mydumpfile.sql

# 덤프파일 적용(복원)
mysqldump -u root -p 스키마명 < 덤프파일명
mysqldump -u root -p board < mydumpfile.sql