-- #1
select * from books
where book_price is null or book_price = 0;

-- #2
select * from books
where book_price is not null and book_circulation is null;

-- #3
select * from books
where book_date is null;

-- #4
select * from books
where book_date >= (current_date() - interval 1 year);

-- #5
select * from books
where book_novelty = "yes"
order by book_price asc;

-- #6
select * from books
where book_pages between 300 and 400
order by book_name desc;

-- #7
select * from books
where book_price between 20 and 40
order by book_date desc;

-- #8
select * from books
order by book_name asc, book_price desc;

-- #9
select * from books
where book_price/book_pages < 0.10;

-- #10
select char_length(book_name) as name_length, upper(substring(book_name, 1, 20)) as book_name20 from books;

-- #11
select lower(concat(substring(book_name, 1, 10), "..." ,substring(book_name, -10))) from books;

-- #12
select book_name, book_date, day(book_date) as book_day, month(book_date) as book_month, year(book_date) as book_year from books;

-- #13
select book_name, book_date, date_format(book_date, "%d/%m/%Y") as book_date_formatted from books;

-- #14
select book_item, book_price, book_price * 29.33 as book_price_uah, book_price * 0.91 as book_price_euro, book_price * 107 as book_price_rubles from books;

-- #15
select book_item, book_price, floor(book_price * 29.33) as book_price_uah, round(book_price) as book_price_rounded  from books;

-- #16
insert into books(book_item, book_novelty, book_name, book_price, book_publisher, book_pages, book_format, book_date, book_circulation, book_theme, book_category)
values(4942, "Yes", "Мова програмування Python. Лекції та вправи", 19.00, "Абабагаламага", 326, "84х108/16", "2019-02-06", 4000, "Програмування", "Python");

-- #17
insert into books(book_item,  book_name, book_publisher, book_pages, book_format, book_circulation, book_theme, book_category)
values(4142, "Мова програмування Kotlin. Лекції та вправи", "Абабагаламага", 226, "84х108/16",  4060, "Програмування", "Kotlin");

-- #18
delete from books
where year(book_date) < 1990;

-- #19
update books
set book_date = current_date()
where book_date is null;

-- #20
update books
set book_novelty = "yes"
where year(book_date) > 2005;