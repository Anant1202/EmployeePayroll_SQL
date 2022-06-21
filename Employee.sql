--UC1
create database Employee;
--UC2
use Employee;
create table emp_payroll(empid int identity(1,1) primary key,empname varchar(200), salary bigint, start_date date);
select * from emp_payroll;
--UC3
insert into emp_payroll values('Rahul',20000,'2021-6-11');
insert into emp_payroll values('Sam',25000,'2020-3-1');
insert into emp_payroll values('Aryan',32000,'2017-8-21');
insert into emp_payroll values('Karan',50000,'2019-4-9');
insert into emp_payroll values('Pooja',35000,'2020-1-5');
insert into emp_payroll values('Komal',70000,'2012-12-2');
--UC4
select * from emp_payroll;
--UC5
select salary from emp_payroll where empname = 'Aryan';
select * from emp_payroll where start_date between CAST('2019-3-1' as date) and GETDATE();
--UC6
alter table emp_payroll add gender varchar(200);
update emp_payroll set gender='M'where empname='Rahul' or empname='Sam' or empname='Aryan' or empname='Karan';
update emp_payroll set gender='F'where empname='Pooja' or empname='Komal';
select * from emp_payroll;
--UC7
select SUM(salary) as TotalSalary from emp_payroll where gender ='F' GROUP BY gender;
select SUM(salary) as TotalSalary from emp_payroll where gender ='M' GROUP BY gender;
select AVG(salary) as AverageSalary from emp_payroll where gender='F' GROUP BY gender;
select AVG(salary) as AverageSalary from emp_payroll where gender='M' GROUP BY gender;
select MIN(salary) as MinimumSalary from emp_payroll where gender='F' GROUP BY Gender;
select MIN(salary) as MinimumSalary from emp_payroll where gender='M' GROUP BY Gender;
select MAX(salary) as MaximumSalary from emp_payroll where gender='F' GROUP BY Gender;
select MAX(salary) as MaximumSalary from emp_payroll where gender='M' GROUP BY Gender;
select COUNT(salary) as CountSalary from emp_payroll where gender='F' GROUP BY Gender;
select COUNT(salary) as CountSalary from emp_payroll where gender='M' GROUP BY Gender;
--UC8
alter table emp_payroll add phoneNumber bigInt,department varchar(200) not null default 'developer',address varchar(200) default 'Mumbai';

update emp_payroll set phoneNumber=9127805095,department='testing',address='Bangalore' where empname='Rahul';
update emp_payroll set phoneNumber=8245169056 where empname='Sam';
update emp_payroll set phoneNumber=9006726123,department='manager',address='Delhi' where empname='Aryan';
update emp_payroll set phoneNumber=7045281412,department='testing',address='Pune' where empname='Karan';
update emp_payroll set phoneNumber=9257182456,department='developer',address='Gujarat' where empname='Pooja';
update emp_payroll set phoneNumber=8056182392,address='Bangalore' where empname='Komal';
select * from emp_payroll;

--UC9
alter table emp_payroll add Deduction float,TaxablePay float, IncomeTax float, NetPay float;
update emp_payroll set Deduction=2000 where Gender='F';
update emp_payroll set Deduction=3000 where Gender='M';
update emp_payroll set NetPay=(salary - Deduction);
update emp_payroll set TaxablePay=0,IncomeTax=0;
select * from emp_payroll;

--UC10
insert into emp_payroll(empname,salary,start_date,gender,phoneNumber,department,address) values ('Komal',150000,'2019-02-18','F',9468954840,'senior manager','Pune');
select * from emp_payroll;