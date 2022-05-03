drop database if exists militarydb;


create database militarydb;


use militarydb;


create table bank_account(
	bank_account_id int primary key auto_increment,
    bank_account_number char(16) not null
);


create table soldier_rank(
	soldier_rank_id int primary key auto_increment,
    soldier_rank_name varchar(50) not null,
    soldier_rank_salary int not null,
    check(soldier_rank_salary > 0)
);


create table document_type(
	document_type_id int primary key auto_increment,
    document_type_name varchar(50)
);


create table current_task(
	current_task_id int primary key auto_increment,
    current_task_name varchar(100) not null
);


create table soldier(
	soldier_id int primary key auto_increment,
    soldier_name varchar(50) not null,
    soldier_surname varchar(50) not null,
    soldier_second_name varchar(50) not null,
    soldier_birth_date date not null,
    soldier_serving_start date not null,    
    soldier_serving_end date default null,
    soldier_rank_id int,
    soldier_bank_account_id int,
    soldier_current_task_id int,
    foreign key(soldier_rank_id) references soldier_rank(soldier_rank_id),
    foreign key(soldier_bank_account_id) references bank_account(bank_account_id),
    foreign key(soldier_current_task_id) references current_task(current_task_id),
    check(soldier_serving_start < soldier_serving_end)
);

create table document(
	document_id int primary key auto_increment,
    document_date date not null,
    document_context varchar(1000) not null,
    document_from int,
    document_to int default null,
    document_signed_by int default null,
    document_type int,
    foreign key(document_from) references soldier(soldier_id),
    foreign key(document_to) references soldier(soldier_id),
    foreign key(document_signed_by) references soldier(soldier_id),
    foreign key(document_type) references document_type(document_type_id)
);


insert into bank_account(bank_account_number) values
('0023005498265412'),
('0658456200129573'),
('4568123698020101'),
('0185964752648856'),
('4456321789001235'),
('4722300156481244'),
('9657321468514620'),
('0123525246891601');


select * from bank_account 
order by bank_account_id;


insert into soldier_rank(soldier_rank_name, soldier_rank_salary) values
('Рядовий', 10000),
('Капітан', 12500),
('Лейтенант', 14000),
('Генерал', 22000),
('Командир', 13000);


select * from soldier_rank
order by soldier_rank_salary asc;


insert into document_type(document_type_name) values
('Рапорт'),
('Заява'),
('Наказ');


select * from document_type
order by document_type_name;


insert into current_task(current_task_name) values 
('Бойові вчення'),
('Відпустка'),
('Патруль'),
('У зоні бойових дій'),
('Резерв'),
('Бюрократія');


select * from current_task
order by current_task_name;


insert into soldier(soldier_name, soldier_surname, soldier_second_name, soldier_birth_date, soldier_serving_start, soldier_rank_id, soldier_bank_account_id, soldier_current_task_id) values
('Дмитро', 'Семинога', 'Олександрович', '1995-05-26', '2015-02-01', 1, 1, 1),
('Валерій', 'Погайда', 'Олегович', '1999-07-30', '2021-10-06', 1, 2, 3),
('Егор', 'Коваль', 'Дмитрович', '2000-01-06', '2022-11-17', 2, 3, 2),
('Олег', 'Пасічник', 'Миколайович', '1986-12-08', '2006-10-13', 3, 4, 2),
('Микола', 'Кранченко', 'Андрійович', '1972-02-26', '1990-04-12', 4, 5, 6),
('Святослав', 'Блаженний', 'Валерійович', '1996-09-18', '2013-05-22', 1, 6, 5),
('Володимир', 'Кличко', 'Володимирович', '1989-03-20', '2007-04-08', 5, 7, 6),
('Олександр', 'Малюк', 'Егорович', '1965-12-12', '1982-06-19', 5, 8, 4);


select * from soldier
order by soldier_id;

insert into document(document_date, document_context, document_to, document_from, document_signed_by, document_type) values
('2015-08-28', 'Прошу підвищення...', 3, 1, null, 2),
('2022-05-19', 'Доповідаю про стан підготовки навчання...', 3, 6, 6, 1),
('2021-11-01', 'Наказую виконати завдання №5...', null, 5, 5, 3);


select * from document
order by document_id;


select soldier_name, soldier_surname, soldier_rank_name, current_task_name from soldier
join soldier_rank on soldier.soldier_rank_id = soldier_rank.soldier_rank_id
join current_task on soldier_current_task_id = current_task_id
order by soldier_rank_name;

select soldier_name, soldier_surname from soldier
where soldier_current_task_id in (
	select current_task_id from current_task
    where current_task_name = 'Відпустка'
);
