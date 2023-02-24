//
//  ViewController.swift
//  CodeClean-1
//
//  Created by BKS-GGS on 15/02/23.
//

import UIKit

/*****************************************************************************************************
 
 
                            P O L Y M O R P H I S M
 
 ***************************************************************************************************/

// Problem statement: When we are going with Switch case, what are all the problems we are going to face :(

//public Money calculatePay(Employee e) throws InvalidEmployeeType {
//switch (e.type) { case COMMISSIONED:
//return calculateCommissionedPay(e); case HOURLY:
//return calculateHourlyPay(e); case SALARIED:
//return calculateSalariedPay(e); default:
//throw new InvalidEmployeeType(e.type); }
//}


struct Money {
    let pay: Int
}

struct Employee {
    let type: EmployeeType
}

enum EmployeeType: Error {
    case COMMISSIONED
    case HOURLY
    case SALARIED
    case Invalid
}

func calcualtePay(_ e: Employee) throws -> Money {
    switch (e.type) {
    case .COMMISSIONED:
        return calculateCommissionedPay(e)
    case .HOURLY:
        return calculateHourlyPay(e)
    case .SALARIED:
        return calculateSalariedPay(e)
    default:
        throw EmployeeType.Invalid
    }
}


func calculateCommissionedPay(_ e: Employee) -> Money {
    return Money(pay: 200)
}

func calculateHourlyPay(_ e: Employee) -> Money {
    return Money(pay: 500)
}

func calculateSalariedPay(_ e: Employee ) -> Money {
    return Money(pay: 20000)
}


// Growing....

func isPayday(_ e: Employee, date: Date) {
    // switch
    switch (e.type) {
    case .COMMISSIONED:
        return isPayDayOnCommissionedEmployee(e, date)
    case .HOURLY:
        return isPayDayOnHourlyEmployee(e, date)
    case .SALARIED:
        return isPayDayOnSalariedEmployee(e, date)
    default: break
    }
}

func isPayDayOnCommissionedEmployee(_ e: Employee, _ date: Date) {
    // Employee who works on commision based
}

func isPayDayOnHourlyEmployee(_ e: Employee, _ date: Date) {
    // Employee who works on Hourly based
}

func isPayDayOnSalariedEmployee(_ e: Employee, _ date: Date) {
    // Employee who works on Salarie based
}


func deliverPay(_ e: Employee, pay: Money) {
    // custom logic
}
//continuty on more functions like this.

/*
There are several problems with this function.

First, it’s large, and when new employee types are added, it will grow.
Second, it very clearly does more than one thing.
Third, it violates the Single Responsibility Principle7 (SRP) because there is more than one reason for it to change.
Fourth, it violates the Open Closed Principle8 (OCP) because it must change whenever new types are added. But possibly the worst problem with this function is that there are an unlimited number of other functions that will have the same structure. For example we could have

isPayday(Employee e, Date date),
or
deliverPay(Employee e, Money pay),
*/

//SOLUTION:
/*
 The solution to this problem (see Listing 3-5) is to bury the switch statement in the basement of an ABSTRACT FACTORY,9 and never let anyone see it. The factory will use the switch statement to create appropriate instances of the derivatives of Employee, and the var- ious functions, such as calculatePay, isPayday, and deliverPay, will be dispatched poly- morphically through the Employee interface.
 */

//Employee and Factory

struct EmployeeRecord {
    let type: EmployeeType
}

class AbstractEmployee {
    let record: EmployeeRecord
    
    init(record: EmployeeRecord) {
        self.record = record
    }
    func isPayday() -> Bool {
        fatalError("abstract function should not get called")
    }
    func calculatePay() -> Money {
        fatalError("abstract function should not get called")
    }
    func deliverPay(pay: Money ) {
        fatalError("abstract function should not get called")
    }
    func isPayday(date: Date) {
        fatalError("abstract function should not get called")
    }
}

//Protocols that describe what something is should read as nouns (e.g. Collection).
//Protocols that describe a capability should be named using the suffixes able, ible, or ing (e.g. Equatable, ProgressReporting).
protocol EmployeeFactorable {
    func makeEmployee(r: EmployeeRecord) throws -> AbstractEmployee
}

class EmployeeFactory: EmployeeFactorable {
    func makeEmployee(r: EmployeeRecord) throws -> AbstractEmployee {
        switch (r.type) {
        case .COMMISSIONED:
            return CommissionedEmployee(record: r)
        case .HOURLY:
            return HourlyEmployee(record: r)
        case .SALARIED:
            return SalariedEmploye(record: r)
        default:
            throw EmployeeType.Invalid
        }
    }
}

class CommissionedEmployee: AbstractEmployee {
    override func isPayday() -> Bool {
        return true
    }
    
    override func calculatePay() -> Money {
        return Money(pay: 20)
    }
    
    override func deliverPay(pay: Money) {
        print(pay.pay)
    }
    
    override func isPayday(date: Date) {
        
    }
}

class HourlyEmployee: AbstractEmployee {
    override func isPayday() -> Bool {
        return true
    }
    
    override func calculatePay() -> Money {
        return Money(pay: 40)
    }
    
    override func deliverPay(pay: Money) {
        print(pay.pay)
    }
    
    override func isPayday(date: Date) {
        
    }
}

class SalariedEmploye: AbstractEmployee {
    override func isPayday() -> Bool {
        return true
    }
    
    override func calculatePay() -> Money {
        return Money(pay: 20000)
    }
    
    override func deliverPay(pay: Money) {
        print(pay.pay)
    }
    
    override func isPayday(date: Date) {
        
    }
}

// ViewController calss
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        print("farmer")
        do {
            let farmer = try PersonFactory.make(person: .init(type: .Farmer))
            farmer.wakeup()
            farmer.breakfast()
            farmer.lunch()
            farmer.dinner()
            farmer.sleep()
        } catch(let err) {
          print(err)
        }
        
        print("student")
        do {
            let student = try PersonFactory.make(person: .init(type: .Student))
            student.wakeup()
            student.breakfast()
            student.lunch()
            student.dinner()
            student.sleep()
        } catch(let err) {
          print(err)
        }
            
        
        /*
        do {
            let commissionedEmployee = try EmployeeFactory().makeEmployee(r: EmployeeRecord(type: .COMMISSIONED))
            
            _ = commissionedEmployee.calculatePay()
            commissionedEmployee.deliverPay(pay: Money(pay: 20))
            commissionedEmployee.isPayday(date: Date())
            
        } catch(let err) {
            print(err)
        }
        
        
        do {
            let hourlyEmployee = try EmployeeFactory().makeEmployee(r: EmployeeRecord(type: .HOURLY))
            
            _ = hourlyEmployee.calculatePay()
            hourlyEmployee.deliverPay(pay: Money(pay: 500))
            hourlyEmployee.isPayday(date: Date())
            
        } catch(let err) {
            print(err)
        }
        
        do {
            let salariedEmployee = try EmployeeFactory().makeEmployee(r: EmployeeRecord(type: .SALARIED))
            
            _ = salariedEmployee.calculatePay()
            salariedEmployee.deliverPay(pay: Money(pay: 20000))
            salariedEmployee.isPayday(date: Date())
            
        } catch(let err) {
            print(err)
        }
        */
        
    }


}

//
//-----------------
//public interface EmployeeFactory {
//public Employee makeEmployee(EmployeeRecord r) throws InvalidEmployeeType; }
//-----------------
//public class EmployeeFactoryImpl implements EmployeeFactory {
//public Employee makeEmployee(EmployeeRecord r) throws InvalidEmployeeType { switch (r.type) {
//case COMMISSIONED:
//return new CommissionedEmployee(r) ;
//case HOURLY:
//return new HourlyEmployee(r);
//case SALARIED:
//return new SalariedEmploye(r);
//default:
//throw new InvalidEmployeeType(r.type);
//} }
//}


/* PROBLEM STATEMENT */
// Todo; Lets take an example: there are three type of person in the village. and each of them have their own routines.
// followed by:
// Farmer -> wakeup() { at 3am} ; breakfast( at 6am); lunch( at 12); dinner(at 7); sleepTime(at 8)
// Student -> wakeup() { at 8.30am} ; breakfast( at 9am); lunch( at 1.30); dinner(at 9); sleepTime(at 12)
// IT Professional -> wakeup() { at 8.00am} ; breakfast( at 8.45am); lunch( at 1.30); dinner(at 9); sleepTime(at 10.30)
// Come up with your own approach how to solve this?

enum PersonType: Error {
    case Farmer
    case Student
    case ITProfressional
    case Invalid
}

struct Person {
    let type: PersonType
}

//Abstract base class
protocol Personable {
    var person: Person { get set}
    func wakeup()
    func breakfast()
    func lunch()
    func dinner()
    func sleep()
}

protocol Personel {
    func make(person: Person) throws -> Personable
}

struct PersonFactory {
   static func make(person: Person) throws -> Personable {
        switch person.type {
        case .Farmer:
            return Farmer(person: person)
        case .Student:
            return Student(person: person)
        case .ITProfressional:
            return ITProfessional(person: person)
        default: throw PersonType.Invalid
        }
    }
}

// Farmer -> wakeup() { at 3am} ; breakfast( at 6am); lunch( at 12); dinner(at 7); sleepTime(at 8)
struct Farmer: Personable {
    var person: Person
    init(person: Person) {
        self.person = person
    }
    
    func wakeup() {
        print("3am")
    }
    
    func breakfast() {
        print("6am")
    }
    
    func lunch() {
        print("12pm")
    }
    
    func dinner() {
        print("7pm")
    }
    
    func sleep() {
        print("8pm")
    }
}

// Student -> wakeup() { at 8.30am} ; breakfast( at 9am); lunch( at 1.30); dinner(at 9); sleepTime(at 12)
struct Student: Personable {
    var person: Person
    init(person: Person) {
        self.person = person
    }
    
    func wakeup() {
        print("8.30am")
    }
    
    func breakfast() {
        print("9am")
    }
    
    func lunch() {
        print("1.30pm")
    }
    
    func dinner() {
        print("9pm")
    }
    func sleep() {
        print("12am")
    }
}

// IT Professional -> wakeup() { at 8.00am} ; breakfast( at 8.45am); lunch( at 1.30); dinner(at 9); sleepTime(at 10.30)
struct ITProfessional: Personable {
    var person: Person
    init(person: Person) {
        self.person = person
    }
    
    func wakeup() {
        print("8am")
    }
    
    func breakfast() {
        print("8.45am")
    }
    
    func lunch() {
        print("1.30pm")
    }
    
    func dinner() {
        print("9pm")
    }
    func sleep() {
        print("10.30pm")
    }
}

