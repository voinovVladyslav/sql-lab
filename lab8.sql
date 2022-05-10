-- #1
delimiter //
create trigger theme_limit before insert on theme
for each row 
begin
	declare total_theme int;
	set total_theme = (select count(*) from theme);
	if total_theme = 10	then
		signal sqlstate '45000' set message_text = 'Theme limit reached';
	end if; 
end; //
delimiter ;


delimiter //
create trigger theme_limit_min before delete on theme
for each row 
begin
	declare total_theme int;
	set total_theme = (select count(*) from theme);
	if total_theme = 5 then 
		signal sqlstate '45001' set message_text = 'Theme limit reached';
	end if; 
end; //
delimiter ;


delete from theme where theme_id > 3; -- on delete trigger test


insert into theme(theme_name) values  -- on update trigger test
('Linus Torvalds'),
('C#');



-- #2
delimiter //
create trigger novelty_year before insert on book
for each row 
begin
	if year(new.book_date) != year(current_date()) then
		set new.book_novelty = "No";
	end if; 
end; //
delimiter ;


insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5043, 'Yes', 'MySQL', 15.00, 400, '2000-07-24', 4000, 1, 1, 1, 1);


select * from book order by book_id desc; -- on insert trigger test



-- #3
delimiter //
create trigger price_restrictions before insert on book
for each row 
begin
	if new.book_pages < 100 then
		if new.book_price > 10 then
			signal sqlstate '45002' set message_text = "price didn't match with pages count";
		end if;
	elseif new.book_pages < 200 then
		if new.book_price > 20 then
			signal sqlstate '45002' set message_text = "price didn't match with pages count";
		end if;
	elseif new.book_pages < 300 then
		if new.book_price > 30 then
			signal sqlstate '45002' set message_text = "price didn't match with pages count";
		end if;
	end if;
end ; //
delimiter ;


-- trigger test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5043, 'Yes', 'MySQL', 150.00, 299, '2000-07-24', 4000, 1, 1, 1, 1);



-- #4
delimiter //
create trigger publisher_BHV_restriction before insert on book
for each row 
begin
	declare BHV_id int;
    set BHV_id = (select publisher_id from publisher where publisher_name like '%BHV%');
    if new.publisher_id = BHV_id then
		if new.book_circulation < 5000 then
			signal sqlstate "45000" set message_text = 'This book circulation invalid due to publisher restriction';
        end if;
	end if;
end; //
delimiter ;


delimiter //
create trigger publisher_DiaSoft_restriction before insert on book
for each row 
begin
	declare DiaSoft_id int;
    set DiaSoft_id = (select publisher_id from publisher where publisher_name like '%DiaSoft%');
    if new.publisher_id = DiaSoft_id then
		if new.book_circulation < 10000 then
			signal sqlstate "45000" set message_text = 'This book circulation invalid due to publisher restriction';
        end if;
	end if;
end; //
delimiter ;


-- trigger BHV test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5043, 'Yes', 'MySQL', 15.00, 400, '2000-07-24', 4000, 1, 1, 1, 1);


-- trigger DiaSoft test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5043, 'Yes', 'MySQL', 15.00, 400, '2000-07-24', 4000, 1, 1, 4, 1);



-- #5
delimiter //
create trigger book_item_restriction before insert on book
for each row 
begin
	if exists(select * from book where book_item = new.book_item) then
    select book_novelty, book_name, book_price, book_pages, book_date, book_circulation into
	@novelty, @bname, @price, @pages, @bdate, @circulation from book where book_item = new.book_item order by book_id limit 1;
		if (new.book_novelty != @novelty or new.book_name !=@bname or new.book_price != @price or new.book_pages != @pages or new.book_circulation != @circulation) then
			signal sqlstate "45000" set message_text = 'invalid data for this item';
        end if;
    end if;
end; //
delimiter ;


-- trigger test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5049, 'Yes', 'MySQL', 16.00, 400, '2000-07-24', 6000, 1, 1, 1, 1);


select * from book order by book_id desc;



-- #6
delimiter //
create trigger book_deletion_count after delete on book
for each row 
begin
	if user() != 'dbo@localhost' then
		signal sqlstate "45000" set message_text = 'this user is not allowed to delete rows';
	end if;
	set @deletion_sum = @deletion_sum + 1;
end; //
delimiter ;


-- triger test
set @deletion_sum = 0;


delete from book where book_id > 25;


select @deletion_sum;



-- #7
delimiter //
create trigger book_price_change before update on book
for each row 
begin
	if user() = 'dbo@localhost' then
		if new.book_price != old.book_price then
			signal sqlstate "45000" set message_text = "current user can't change price";
        end if;
	end if;
end; //
delimiter ;


-- trigger test
update book set book_price = 22 where book_id = 25;



-- #8
delimiter //
create trigger publisher_restriction before insert on book
for each row 
begin
	declare DMK_id int;
    declare Ecom_id int;
    declare book_category_id varchar(100);
	set DMK_id = (select publisher_id from publisher where publisher_name like '%ДМК%');
	set Ecom_id = (select publisher_id from publisher where publisher_name like '%Эком%');
    set book_category_id = (select category_id from category where category_name like '%Підручники%');
    
    if (new.publisher_id = DMK_id or new.publisher_id = Ecom_id) and new.category_id = book_category_id then
		signal sqlstate "45000" set message_text = 'This publisher cannot publish this category';
    end if;
end; //
delimiter ;


-- trigger test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5049, 'Yes', 'MySQL', 16.00, 400, '2000-07-24', 6000, 1, 1, 7, 1);



-- #9
delimiter //
create trigger novelty_restriction_2 before insert on book
for each row 
begin
	declare novelty_count int;
	set novelty_count = (select count(*) from book where year(new.book_date) = year(book_date) and month(new.book_date) = month(book_date) and new.publisher_id = publisher_id and book_novelty = "Yes");
    if novelty_count > 10 then
		signal sqlstate "45000" set message_text = 'Publisher novelty limit reached for this month';
    end if;
end; //
delimiter ;


-- trigger test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5045, 'No', 'MySQL', 16.00, 400, '2022-04-24', 6000, 1, 1, 1, 1);

select * from book order by book_id;



-- #10
delimiter //
create trigger publisher_restriction_2 before insert on book
for each row 
begin
	declare BHV_id int;
    declare book_shape_id varchar(100);
	set BHV_id = (select publisher_id from publisher where publisher_name like '%BHV%');
    set book_shape_id = (select shape_id from shape where shape_name = '60х88/16');
    
    if new.publisher_id = BHV_id and new.shape_id = book_shape_id then
		signal sqlstate "45000" set message_text = 'This publisher cannot publish this shape';
    end if;
end; //
delimiter ;


-- trigger test
insert into book(book_item, book_novelty, book_name, book_price, book_pages, book_date, book_circulation, theme_id, category_id, publisher_id, shape_id) values
(5049, 'Yes', 'MySQL', 16.00, 400, '2000-07-24', 6000, 1, 1, 1, 3);
