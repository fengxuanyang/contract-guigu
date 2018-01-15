pragma solidity ^0.4.14;

contract Payroll {

  struct Employee {
    address id  ;
    uint salary  ;
    uint lastPayday ;
  }
  uint constant payCycle  = 10 seconds;
  address owner ;
   uint totalsalary = 0 ;
  mapping(address => Employee) employees;

  function Payroll() {
    owner = msg.sender;
  }

  function _payFullSal(Employee  employee) private {
    uint fullSalary = employee.salary *(now - employee.lastPayday) / payCycle;
    employee.id.transfer(fullSalary);
  }


  function addFound() payable returns(uint) {
    return this.balance ;
  }

  function calculRunway() returns(uint) {
    return (this.balance / totalsalary);
  }

  function addEmployee(address eaddr ,uint sal) {
    require(msg.sender == owner );
    var employee =  employees[eaddr];
    assert(employee.id == 0x0);
    totalsalary += sal  * (1 ether);
    employees[eaddr] = Employee(eaddr, sal * (1 ether), now);
  }

  function  removeEmployee(address eaddr) {
    require(msg.sender == owner);
    var employee  =  employees[eaddr];
    assert(employee.id != 0x0);
     _payFullSal(employee);
    totalsalary -=  employees[eaddr].salary;
    delete employees[eaddr];
   }

  function updateEmployee(address eaddr ,uint newsal) {
    require(msg.sender == owner );
     var employee  = employees[eaddr];
    assert(employee.id != 0x0);
    _payFullSal(employee);
    totalsalary = totalsalary - employee.salary + newsal  * (1 ether);
    employees[eaddr].salary = newsal  * (1 ether);
    employees[eaddr].lastPayday =now;
  }

    function isExis() returns(address,bool)  {
    var  employee  = employees[msg.sender];
    return (employee.id,employee.id !=0x0);
   }


  function getSalary()    {
    var  employee  = employees[msg.sender];
    require(employee.id != 0x0);
    uint nextPayday = employee.lastPayday + payCycle;
    assert(nextPayday < now);
    // employees[employee.id].lastPayday = nextPayday;
    employee.lastPayday = nextPayday;
    employee.id.transfer(employee.salary);
   }
}
