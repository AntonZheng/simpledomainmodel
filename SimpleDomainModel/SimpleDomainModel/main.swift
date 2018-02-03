//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
    
    init(amount: Int, currency: String){
        self.amount = amount
        self.currency = currency
    }
  
  
  public func convert(_ to: String) -> Money {
    switch (self.currency, to){
        case ("USD","GBP"):
            return Money(amount: self.amount/2 , currency: to)
        case ("USD","EUR"):
            return Money(amount: (self.amount * 3)/2, currency: to)
        case ("USD","CAN"):
            return Money(amount: (self.amount * 5)/4, currency: to)
        case ("GBP","USD"):
            return Money(amount: self.amount*2, currency: to)
        case ("GBP","EUR"):
            return Money(amount: (self.amount * 9)/8, currency: to)
        case ("GBP","CAN"):
            return Money(amount: (self.amount * 19)/11, currency: to)
        case ("EUR","USD"):
            return Money(amount: (self.amount * 2)/3, currency: to)
        case ("EUR","GBP"):
            return Money(amount: (self.amount * 8)/9, currency: to)
        case ("EUR","CAN"):
            return Money(amount: (self.amount * 3)/2, currency: to)
        case ("CAN","USD"):
            return Money(amount: (self.amount * 4)/5, currency: to)
        case ("CAN","GBP"):
            return Money(amount: (self.amount * 11)/19, currency: to)
        case ("CAN","EUR"):
            return Money(amount: (self.amount * 2)/3, currency: to)
        default:
            return self
    }
  }
  
  public func add(_ to: Money) -> Money {
    let convert = self.convert(to.currency)
    return Money(amount: convert.amount + to.amount, currency: to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    let convert = self.convert(from.currency)
    return Money(amount: convert.amount - from.amount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Hourly(let hourly):
        return Int(Double(hours) * hourly)
    case .Salary(let salary):
        return salary
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let hourly):
        self.type = JobType.Hourly(hourly+amt)
    case .Salary(let salary):
        self.type = JobType.Salary(Int(Double(salary) + amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
        return self._job
    }
    set(value) {
        if(self.age >= 16){
            self._job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {return self._spouse }
    set(value) {
        if(self.age >= 18){
            self._spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self.job)) spouse:\(String(describing: self.spouse))]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    self.members.append(spouse1)
    self.members.append(spouse2)
  }
  
  open func haveChild(_ child: Person) -> Bool {
    members.append(child)
    return true
  }
  
  open func householdIncome() -> Int {
    var result = 0
    for member in self.members {
        if((member.job?.calculateIncome(2000)) != nil){
            result += (member.job?.calculateIncome(2000))!
        }
    }
    return result
  }
}





