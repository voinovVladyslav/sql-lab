-- #1
select book_id, book_item, book_novelty, book_name, book_price, book_pages from books;

-- #2
select * from books;

-- #3
select book_item, book_name, book_novelty, book_pages, book_price, book_id from books;

-- #4
select * from books
order by book_id
limit 10;

-- #5 wrong
select * from books
order by book_id;

-- #6
select distinct book_item from books;

-- #7
select * from books
where book_novelty = "Yes";

-- #8
select * from books
where book_novelty = "Yes" and book_price between 20 and 30;

-- #9
select * from books
where book_novelty = "Yes" and (book_price < 20 or book_price > 30);

-- #11
select * from books
where book_date between "2000-01-01" and "2000-02-28";

-- #12
select * from books
where book_item in (5110, 5141, 4985, 4241);

-- #13
select * from books
where year(book_date) in (1999, 2001, 2003, 2005);

-- #14
select * from books
where book_name regexp '^[а-к]';

-- #15
select * from books
where book_name like "АПП%" and year(book_date) = 2000 and book_price < 20;

-- #16
select * from books
where book_name like "АСС%" and book_name like "%е" and (book_date between "2000-01-01" and "2000-01-30");

-- #17
select * from books
where book_name like "%Microsoft%" and book_name not like "%Windows%";

-- #18
select * from books
where (select char_length(regexp_replace(book_name, "[^0-9]+", ""))) > 0;

-- #19
select * from books
where (select char_length(regexp_replace(book_name, "[^0-9]+", ""))) > 2;

-- #20
select * from books
where (select char_length(regexp_replace(book_name, "[^0-9]+", ""))) = 5;