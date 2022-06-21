---ER digram Used Cases
--Create Table for Company
create Table Company(CompanyID int identity(1,1) primary key,CompanyName varchar(100))
--Insert Values in Company
insert into Company values ('Google')
select * from Company

--Create Employee Table
drop table emp_payroll
create table Employee(EmployeeID int identity(1,1) primary key,CompanyIdentity int,EmployeeName varchar(200),EmployeePhoneNumber bigInt,EmployeeAddress varchar(200),StartDate date,Gender char,Foreign key (CompanyIdentity) references Company(CompanyID));

--Insert Values in Employee
insert into Employee values
(1,'Suhani Yadav',9842905050,'Assam','2012-03-28','F'),
(2,'Ishita Deshmuk',9842905550,'Pune','2017-04-22','F'),
(1,'Vivek',7812905050,'Kolkata','2015-08-22','M'),
(2,'Sarang Sharma',78129050000,'Chandigarh','2012-08-29','M')

select * from Employee

--Create Payroll Table
create table PayrollCalculate(BasicPay float,Deductions float,TaxablePay float,IncomeTax float,NetPay float,EmployeeIdentity int Foreign key references Employee(EmployeeID));
--Insert Values in Payroll Table
insert into PayrollCalculate(BasicPay,Deductions,IncomeTax,EmployeeIdentity) values 
(4000000,1000000,20000,1),
(4500000,200000,4000,2),
(6000000,10000,5000,3),
(9000000,399994,6784,4)

--Update Derived attribute values 
update PayrollCalculate set TaxablePay=BasicPay-Deductions

update PayrollCalculate set NetPay=TaxablePay-IncomeTax

select * from PayrollCalculate

--Create Department Table
create table Department
(DepartmentId int identity(1,1) primary key,DepartName varchar(100))
--Insert Values in Department Table
insert into Department values('Marketing'),('Sales'),('Publishing')

select * from Department

--Create table EmployeeDepartment
create table EmployeeDepartment
(DepartmentIdentity int ,EmployeeIdentity int,Foreign key (EmployeeIdentity) references Employee(EmployeeID),Foreign key (DepartmentIdentity) references Department(DepartmentID))

--Insert Values in EmployeeDepartment
insert into EmployeeDepartment values
(3,1),(2,2),(1,3),(3,4)

select * from EmployeeDepartment
------- UC 12: Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure -------

--UC 4: Retrieve all Data
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,EmployeeAddress,EmployeePhoneNumber,StartDate,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartName
FROM Company
INNER JOIN Employee On Company.CompanyID = Employee.CompanyIdentity
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
INNER JOIN EmployeeDepartment on Employee.EmployeeID=EmployeeDepartment.EmployeeIdentity
INNER JOIN Department on Department.DepartmentId=EmployeeDepartment.DepartmentIdentity

--UC 5: Select Query using Cast() an GetDate()
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity and StartDate BETWEEN Cast('2012-11-12' as Date) and GetDate()
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
--Retrieve query based on Name
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity and Employee.EmployeeName='Kriti Deshmuk'
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID

--UC 7: Use Aggregate Functions and Group by Gender

select Sum(BasicPay) as "TotalSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Avg(BasicPay) as "AverageSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Min(BasicPay) as "MinimumSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Max(BasicPay)  as "MaximumSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Count(BasicPay) as "CountSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;
