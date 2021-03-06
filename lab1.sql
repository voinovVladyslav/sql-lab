-- 2.a
drop database if exists library;

-- 2.b
create database library;
use library;

-- 2.c 
create table books(
	book_id int primary key auto_increment,  -- номер
    book_item int not null,                  -- код
    book_novelty varchar(3), 			     -- новинка
    book_name varchar(100) not null,		 -- назва 
    book_price float default null,			 -- ціна
    book_publisher varchar(30) not null,     -- видавництво
    book_pages int not null,                 -- сторінки
    book_format varchar(20) not null,        -- формат
    book_date date default null,             -- дата
    book_circulation int not null,           -- тираж
    book_theme varchar(50) not null,         -- тема
    book_category varchar(50) not null,      -- категорія
    check (book_circulation > 0),
    check (book_pages > 0),
    check (book_novelty in ("Yes", "No"))
);

-- 2.d 
create index book_date_index on books (book_date);

-- 2.e 
insert into books(book_item, book_novelty, book_name, book_price, book_publisher, book_pages, book_format, book_date, book_circulation, book_theme, book_category)
values
(5110, "No", "Апаратні засоби мультимедіа. Відеосистема РС", 15.51, "Видавнича група BHV", 400, "70х100/16", "2000-07-24", 5000, "Використання ПК в цілому", "Підручники"),
(4985, "No", "Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид", 18.90, "Вільямс", 288, "70х100/16", "2000-07-07", 5000, "Використання ПК в цілому", "Підручники"),
(5141, "No", "Структури даних та алгоритми", 37.80, "Вільямс", 384, "70х100/16", "2000-09-29", 5000, "Використання ПК в цілому", "Підручники"),
(5127, "No", "Автоматизація інженерно-графічних робіт", 11.58, "Видавнича група BHV", 256, "70х100/16", "2000-06-15", 5000, "Використання ПК в цілому", "Підручники"),
(5110, "No", "Апаратні засоби мультимедіа. Відеосистема РС", 15.51, "Видавнича група BHV", 400, "70х100/16", "2000-07-24", 5000, "Використання ПК в цілому", "Апаратні засоби ПК"),
(5199, "No", "Залізо IBM 2001", 30.07, "МикроАрт", 368, "70х100/16", "2000-12-02", 5000, "Використання ПК в цілому", "Апаратні засоби ПК"),
(3851, "No", "Захист інформації та безпека комп'ютерних систем", 26.00, "DiaSoft", 480, "84х108/16", null, 5000, "Використання ПК в цілому", "Захист і безпека ПК"),
(3932, "No", "Як перетворити персональний комп'ютер на вимірювальний комплекс", 7.65, "ДМК", 144, "60х88/16", "1999-06-09", 5000, "Використання ПК в цілому", "Інші книги"),
(4713, "No", "Plug-ins. Додаткові програми для музичних програм", 11.41, "ДМК", 144, "70х100/16", "2000-02-22", 5000, "Використання ПК в цілому", "Інші книги"),
(5217, "No", "Windows МЕ. Найновіші версії програм", 16.57, "Триумф", 320, "70х100/16", "2000-08-25", 5000, "Операційні системи", "Windows 2000"),
(4829, "No", "Windows 2000 Professional крок за кроком з CD", 27.25, "Эком", 320, "70х100/16", "2000-04-28", 5000, "Операційні системи", "Windows 2000"),
(5170, "No", "Linux версії", 24.43, "ДМК", 346, "70х100/16", "2000-09-29", 5000, "Операційні системи", "Linux"),
(860, "No", "Операційна система UNIX", 3.50, "Видавнича група BHV", 395, "84х100/16", "1997-05-05", 5000, "Операційні системи", "Unix"),
(44, "No", "Відповіді на актуальні запитання щодо OS/2 Warp", 5.00, "DiaSoft", 352, "60х84/16", "1996-03-20", 5000, "Операційні системи", "Інші операційні системи"),
(5176, "No", "Windows Ме. Супутник користувача", 12.79, "Видавнича група BHV", 306, "", "2000-10-10", 5000, "Операційні системи", "Інші операційні системи"),
(5462, "No", "Мова програмування С++. Лекції та вправи", 29.00, "DiaSoft", 656, "84х108/16", "2000-12-12", 5000, "Програмування", "C&C++"),
(4982, "No", "Мова програмування С. Лекції та вправи", 29.00, "DiaSoft", 432, "84х108/16", "2000-07-12", 5000, "Програмування", "C&C++"),
(4687, "No", "Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів", 17.60, "ДМК", 240, "70х100/16", "2000-02-03", 5000, "Програмування", "C&C++"),
(235, "No", "Інформаційні системи і структури даних", null, "Києво-Могилянська академія", 288, "60х90/16", null, 400, "Використання ПК в цілому", "Інші книги"),
(8749, "Yes", "Бази даних в інформаційних системах", null, 'Університет "Україна"', 418, "60х84/16", "2018-07-25", 100, "Програмування", "SQL"),
(2154, "Yes", "Сервер на основі операційної системи FreeBSD 6.1", 0, 'Університет "Україна"', 216, "60х84/16", "2015-03-11", 500, "Програмування", "Інші операційні системи"),
(2662, "No", "Організація баз даних та знань", 0, "Вінниця: ВДТУ", 208, "60х90/16", "2001-10-10", 1000, "Програмування", "SQL"),
(5641, "Yes", "Організація баз даних та знань", 0, "Видавнича група BHV", 384, "70х100/16", "2021-12-15", 5000, "Програмування", "SQL");

-- 3.a
alter table books
add book_author varchar(15);

-- 3.b
alter table books
modify book_author varchar(20);

-- 3.c
alter table books
drop column book_author;

-- 3.d 
drop index book_date_index on books;
create unique index book_id_index on books (book_id);

-- 3.e
drop index book_id_index on books;