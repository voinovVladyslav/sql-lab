-- #2.a
create table theme(
	theme_id int primary key auto_increment,
    theme_name varchar(50) not null unique      -- тема
);

create table category(
	category_id int primary key auto_increment,
    category_name varchar(50) not null unique   -- категорія 
);

create table publisher(
	publisher_id int primary key auto_increment,
    publisher_name varchar(50) not null unique -- видавництво
);

create table shape(
	shape_id int primary key auto_increment,
    shape_name varchar(20) not null unique     -- формат
);

create table book(
	book_id int primary key auto_increment,  -- номер
    book_item int not null,                  -- код
    book_novelty varchar(3), 			     -- новинка
    book_name varchar(100) not null,		 -- назва 
    book_price float default null,			 -- ціна
    book_pages int not null,                 -- сторінки
    book_date date default null,             -- дата
    book_circulation int not null,           -- тираж
    theme_id int,
    category_id int,
    publisher_id int,
    shape_id int,
    foreign key(theme_id) references theme(theme_id),
    foreign key(category_id) references category(category_id),
    foreign key(publisher_id) references publisher(publisher_id),
    foreign key(shape_id) references shape(shape_id),
    check (book_circulation > 0),
    check (book_pages > 0),
    check (book_novelty in ("Yes", "No"))
);

-- #2.b 
insert into theme(theme_name)
select distinct book_theme from books;

insert into category(category_name)
select distinct book_category from books;

insert into publisher(publisher_name)
select distinct book_publisher from books;

insert into shape(shape_name)
select distinct book_format from books;

insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id)
select book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id from books
join theme on theme.theme_name = books.book_theme
join category on category.category_name = books.book_category
join publisher on publisher.publisher_name = books.book_publisher
join shape on shape.shape_name = books.book_format;

select * from book;