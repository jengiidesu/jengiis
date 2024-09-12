use my_cat;

create table cat_board(
	num int primary key auto_increment, 
    title char(255),
    content text,
    id char(30)
);

select * from cat_board;

insert into cat_board values(0,'테스트제목','테스트내용 내용.......','cat4');
