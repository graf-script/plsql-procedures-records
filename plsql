CREATE OR REPLACE FUNCTION totalEmployees
RETURN NUMBER IS
    total NUMBER(5):= 0;
BEGIN
    SELECT COUNT(*) INTO total
    FROM employees;

    RETURN total;
END;

DECLARE
    c NUMBER(5);
BEGIN
    c := totalEmployees();
    dbms_output.put_line('Total number of employees is: ' || c);
END;

CREATE OR REPLACE PROCEDURE greetings
AS
BEGIN
    dbms_output.put_line('Hello World!');
END;
/

EXECUTE greetings;
/

BEGIN
    greetings;
END;

-- Пример режима IN & OUT 1 
-- Эта программа находит минимум двух значений. Здесь процедура берет два числа, используя режим IN, и возвращает их минимум, используя параметры OUT.

DECLARE 
    a number;
    b number;
    c number;
PROCEDURE findMin(x IN number, y IN number, z OUT number) IS
BEGIN
    IF x < y THEN
        z := x;
    ELSE 
        z := y;
    END IF;
END;

BEGIN 
    a := 23;
    b := 45;
    findMin(a, b, c);
    dbms_output.put_line('Minimum of ' || a || ', ' || b || ' is ' || c);
END;
/    

DECLARE
    a number;
PROCEDURE squareNum(x IN OUT number) IS
BEGIN
    x := x * x;
END;

BEGIN
    a := 23;
    squareNum(a);
    dbms_output.put_line(' Square of 23 is: ' || a);
END;

DECLARE 
    employee_rec employees%rowtype;
BEGIN
    SELECT * INTO employee_rec
    FROM employees
    WHERE id = 5;
    dbms_output.put_line('Employee ID: ' || employee_rec.id); 
    dbms_output.put_line('Employee Name: ' || employee_rec.full_name); 
    dbms_output.put_line('Employee Department: ' || cemployee_rec.department); 
    dbms_output.put_line('Employee Salary: ' || employee_rec.annual_salary); 
END; 
/

-- Табличные записи
DECLARE 
    employee_rec employees%rowtype;
BEGIN
    SELECT * INTO employee_rec
    FROM employees
    WHERE id = 5;
    dbms_output.put_line('Employee ID: ' || employee_rec.id); 
    dbms_output.put_line('Employee Name: ' || employee_rec.full_name); 
    dbms_output.put_line('Employee Department: ' || employee_rec.department); 
    dbms_output.put_line('Employee Salary: ' || employee_rec.annual_salary); 
END; 
/

-- Курсорные записи
DECLARE 
    CURSOR employee_cur IS
        SELECT id, full_name, department
        FROM employees;
    employee_rec employee_cur%rowtype;
BEGIN
    OPEN employee_cur;
    LOOP
        FETCH employee_cur INTO employee_rec;
        EXIT WHEN employee_cur%notfound;
        dbms_output.put_line(employee_rec.id || ' ' || employee_rec.full_name);
    END LOOP;
END;
/

-- Пользовательские записи
/*
TYPE 
type_name IS RECORD 
  ( field_name1  datatype1  [NOT NULL]  [:= DEFAULT EXPRESSION], 
   field_name2   datatype2   [NOT NULL]  [:= DEFAULT EXPRESSION], 
   ... 
   field_nameN  datatypeN  [NOT NULL]  [:= DEFAULT EXPRESSION); 
record-name  type_name;
*/

-- Обьявление книжной записи

DECLARE 
TYPE books IS RECORD
(
    title VARCHAR2(50),
    author VARCHAR2(50),
    subject VARCHAR2(100),
    book_id NUMBER(2)
);
book1 books;
book2 books;
BEGIN
    -- book 1 specification
    book1.title := 'C Programming';
    book1.author := 'Nuha Ali';
    book1.subject := 'C programming tutorial';
    book1.book_id := 1;

    -- book 2 specification
    book2.title := 'Tenet Billing';
    book2.author := 'Zara Ali';
    book2.subject := 'Tenet Billing Tutorial';
    book2.book_id := 2;

    -- Print book 1 record 
   dbms_output.put_line('Book 1 title : '|| book1.title); 
   dbms_output.put_line('Book 1 author : '|| book1.author); 
   dbms_output.put_line('Book 1 subject : '|| book1.subject); 
   dbms_output.put_line('Book 1 book_id : ' || book1.book_id); 
   
   -- Print book 2 record 
   dbms_output.put_line('Book 2 title : '|| book2.title); 
   dbms_output.put_line('Book 2 author : '|| book2.author); 
   dbms_output.put_line('Book 2 subject : '|| book2.subject); 
   dbms_output.put_line('Book 2 book_id : '|| book2.book_id); 
END;
/

DECLARE 
    TYPE books IS RECORD
        (
            title VARCHAR2(50),
            author VARCHAR2(50),
            subject VARCHAR2(100),
            book_id NUMBER
        );
    book1 books;
    book2 books;
PROCEDURE printbook (book books) IS
BEGIN
    dbms_output.put_line ('Book  title :  ' || book.title); 
    dbms_output.put_line('Book  author : ' || book.author); 
    dbms_output.put_line( 'Book  subject : ' || book.subject); 
    dbms_output.put_line( 'Book book_id : ' || book.book_id); 
END;

BEGIN 
    -- Book 1 specification 
    book1.title  := 'C Programming'; 
    book1.author := 'Nuha Ali ';  
    book1.subject := 'C Programming Tutorial'; 
    book1.book_id := 6495407;
   
    -- Book 2 specification 
    book2.title := 'Telecom Billing'; 
    book2.author := 'Zara Ali'; 
    book2.subject := 'Telecom Billing Tutorial'; 
    book2.book_id := 6495700;  

    -- Use procedure to print book info
    printbook(book1);
    printbook(book2);
END;
/
