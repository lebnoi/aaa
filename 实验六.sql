use BookDB
insert into BookClass(classNo, className)
values ('C006', '哲学类'), ('C007', '医学类'), ('C008', '益智类'),('C009',''),('C010', '娱乐类')

insert into Book(bookNo, classNo, bookName, authorName, publisherNo)
values ('B201501004', 'C001', 'xxx', '张三', 'P001')
      ,('B201501005', 'C001', 'yyy', '张三', 'P001')
	  ,('B201501006', 'C002', 'aaa', '李四', 'P002')
	  ,('B201501007', 'C003', 'bbb', '李四', 'P002')
	  ,('B201501008', 'C003', 'ccc', '王五', 'P003')

insert into Reader(readerNo, readerName, sex, identifycard)
values('R2014003', '张三', '男', '010207199100014221')
	  ,('R2014004', '李四', '男', '010207199111034221')
	  ,('R2015005', '王五', '男', '010207199101014221')
	  ,('R2015006', '小明', '男', '010207199109014221')
	  ,('R2015007', '小红', '女', '010207199111014222')

insert into Borrow(readerNo, bookNo, shouldDate)
values('R2015001', 'B201601004', '2016-12-01 00:00:00.000'),('R2015001', 'B201601002', '2016-12-02 00:00:00.000'),
	   ('R2015001', 'B201603001', '2016-12-03 00:00:00.000'),('R2015001', 'B201601003', '2016-12-04 00:00:00.000')
	   ,('R2015001', 'B201503002', '2016-12-05 00:00:00.000')
	 ,('R2015002', 'B201601003', '2016-12-06 00:00:00.000'),('R2016002', 'B201601004', '2016-12-07 00:00:00.000')
	 ,('R2015002', 'B201603001', '2016-12-08 00:00:00.000'),('R2015002', 'B201601001', '2016-12-09 00:00:00.000')
	 ,('R2015002', 'B201503002', '2016-12-10 00:00:00.000')
	 ,('R2015002', 'B201601004', '2016-11-07 00:00:00.000'),('R2015003', 'B201601002', '2016-09-07 00:00:00.000')
	 ,('R2015001', 'B201603003', '2016-12-07 00:00:00.000')
	 ,('R2015002', 'B201601002', '2016-08-07 00:00:00.000'),('R2015003', 'B201503002', '2016-07-07 00:00:00.000')
	 ,('R2016001', 'B201601004 ','2016-06-07 00:00:00.000'),('R2016001', 'B201601002', '2017-12-07 00:00:00.000')
	 ,('R2016001', 'B201603001', '2016-04-07 00:00:00.000'),('R2016003', 'B201601004', '2016-09-08 00:00:00.000')
	 ,('R2016001', 'B201503002', '2016-11-06 00:00:00.000')


select * from Reader
update Reader 
set workUnit = '联合立华股份有限公司'
from Reader r
where r.workUnit = '联合股份有限公司'

select * from Book
update Book
set price = price * 0.95
where shopNum = (select max(shopNum) from Book)

select * from Book
update Book
set price = price * 1.1
from Book b
where b.classNo = (select c.classNo from BookClass c where c.className = '经济类')

select * from Book
update Book
set shopNum = shopNum * 1.5
from Book
where bookNo = any(select b.bookNo from Borrow b group by b.bookNo having count(b.bookNo) > 2)

select * from Borrow
update Borrow
set shouldDate = DATEADD(MONTH, 3, shouldDate)
from Borrow
where readerNo = any(select r.readerNo from Reader r where r.workUnit = '统一股份有限公司')


select * from Reader
update Reader
set borrowCount = a.b
from Reader r,(select distinct b.readerNo,count(b.readerNo) from Borrow b group by b.readerNo) A(a,b)
where r.readerNo = a.a 

select * from Borrow
delete from Borrow 
from Book a, Borrow b
where a.price >30 and a.bookNo = b.bookNo

select * from Borrow
delete from Borrow
where bookNo = (select a.bookNo from Book a where a.bookName = '大学英语')  

select * from Reader
delete from Reader
where readerNo not in (select distinct b.readerNo from Borrow b) 

