-- #1
delimiter //
create procedure task1()
begin
	select book_name, book_price, publisher_name, shape_name from book
	join publisher on publisher.publisher_id = book.publisher_id
	join shape on shape.shape_id = book.shape_id;
end // 


call task1() //

-- #2
create procedure task2()
begin 
	select theme_name, category_name, book_name, publisher_name from book
	join theme on theme.theme_id = book.theme_id
	join category on category.category_id = book.category_id
	join publisher on publisher.publisher_id = book.publisher_id
	order by theme_name, category_name;
end //

call task2() //

-- #3
create procedure task3()
begin
	select book_name, publisher_name from book
	join publisher on publisher.publisher_id = book.publisher_id
	where year(book_date) > 2000 and publisher_name like "%BHV%";
end //

call task3() //

-- #4
create procedure task4()
begin
	select sum(book_pages) as all_pages, category_name from book
	join category on category.category_id = book.category_id
	group by category_name
	order by all_pages desc;
end //

call task4() //

-- #5
create procedure task5()
begin
	select avg(book_price) as avg_price from book
	join theme on theme.theme_id = book.theme_id
	join category on category.category_id = book.category_id
	where category_name = 'Linux' and theme_name = 'Використання ПК';
end //

call task5() //

-- #6 out values
create procedure task6()
begin
	select * from book, category, publisher, shape, theme
	where
	book.publisher_id = publisher.publisher_id
	and theme.theme_id = book.theme_id
	and category.category_id = book.category_id
	and shape.shape_id = book.shape_id
	order by book_id;
end //

call task6() //

-- #6 out values
create procedure task6out
(
	out total int
)
begin
	select count(*) into total from book;
end //

call task6out(@total) //
select @total //

-- #7 
create procedure task7()
begin
	select b1.book_name, b1.book_pages from book as b1, book as b2
	where b1.book_pages = b2.book_pages and b1.book_id != b2.book_id
	order by book_pages;
end //

call task7() //

-- #8
create procedure task8()
begin
	select distinct b1.book_id, b1.book_name, b1.book_price from book as b1, book as b2, book as b3
	where 
	b1.book_price = b2.book_price
	and b2.book_price = b3.book_price
	and b3.book_price = b1.book_price
	and b1.book_id != b2.book_id
	and b2.book_id != b3.book_id
	and b3.book_id != b1.book_id
	order by book_price;
end //

call task8() //

-- #9
create procedure task9()
begin
	select book_name from book
	where category_id in (
	select category_id from category
	where category_name like '%C++%'
	);
end //

call task9() //

-- #10
create procedure task10()
begin
	select publisher_name, book_pages from book as b
	join publisher as p on b.publisher_id = p.publisher_id
	where b.publisher_id in (
		select publisher_id from publisher
		where b.book_pages > 400
	);
end //

call task10() //

-- #11 in values
create procedure task11
(
in count int
)
begin
	select category_name, total_books from category, (
		select count(book_name) as total_books, category_id from book
		group by category_id) as c
	where category.category_id = c.category_id and total_books >= count;
end //

call task11(3) //

-- #11 default value
create procedure task11default()
begin
	call task11(3);
end //

call task11default() //

-- #12
create procedure task12()
begin
	select book_name from book
	where exists (
		select publisher_id from publisher
		where publisher_name = 'Видавнича група BHV'
		and publisher.publisher_id = book.publisher_id
	);
end //

call task12() //

-- #13
create procedure task13()
begin
	select book_name from book
	where not exists (
		select publisher_id from publisher
		where publisher_name != 'Видавнича група BHV'
		and publisher.publisher_id = book.publisher_id
	);
end //

call task13() //

-- #14
create procedure task14()
begin
	select theme_name as name from theme
	union 
	select category_name as name from category
	order by name;
end //

call task14() //

-- #15
create procedure task15()
begin
	select substring_index(book_name, ' ', 1) as name from book
	union
	select category_name as name from category
	order by name desc;
end //

call task15() //
delimiter ;
