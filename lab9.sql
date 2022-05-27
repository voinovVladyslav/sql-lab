-- #1
delimiter //

create procedure get_sum_price_for_year(
in book_year int
)
begin
	select sum(book_price) from book
    where year(book_date) = book_year;
end //

delimiter ;

call get_sum_price_for_year(2000);


-- #2
delimiter //

create procedure get_books_by_year(
in book_year int
)
begin
	select * from book
	where year(book_date) = book_year;
end
//

delimiter ;

call get_books_by_year(1999);


-- #4
delimiter //
create procedure book_by_year(
	in book_year int,
    out book_names varchar(9999)
)
begin
	declare finished int default 0;
	declare book_name varchar(100);
    
	declare mycursor 
		cursor for 
			select book_name from book where year(book_date) = book_year;
            
	declare continue handler for not found set finished = 1;
    
    open mycursor;
    
    getbooks: loop
		fetch mycursor into book_name;
        if finished = 1 then
			leave getbooks;
		end if;
        set book_names = concat(book_name,';',book_names);
    end loop getbooks;
    close mycursor;
    
end //

delimiter ;

set @book_names = '';

call book_by_year(2020, @book_names);

select @book_names;














