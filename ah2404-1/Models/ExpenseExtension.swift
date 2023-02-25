//
//  ExpenseExtension.swift
//  ah2404
//
//  Created by Morris Albers on 2/21/23.
//

import Foundation
extension Expense {
    public var internalExpenseDate:Date {
        var comps = DateComponents()
        comps.day = internalExpenseDay
        comps.month = internalExpenseMonth
        comps.year = internalExpenseYear
        
        comps.hour = internalExpenseHour
        comps.minute = internalExpenseMinute
        comps.second = 0

        let date = Calendar.current.date(from: comps)!
        
        return date
    }
    
    public var internalExpenseYear:Int {
        let index = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 4)
        let mySubstring = self.expenseDate[..<index]
        let syear:String = String(mySubstring)
        let iyear = Int(syear) ?? 0
        return iyear
    }

    public var internalExpenseMonth:Int {
        let start = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 5)
        let end = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 6)
        let range = start..<end
        
        let mySubstring = self.expenseDate[range]
        let smonth:String = String(mySubstring)
        let imonth = Int(smonth) ?? 0
        return imonth
    }

    public var internalExpenseDay:Int {
        let start = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 6)
        let end = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 8)
        let range = start..<end
        
        let mySubstring = self.expenseDate[range]
        let sday:String = String(mySubstring)
        let iday = Int(sday) ?? 0
        return iday
    }

    public var internalExpenseHour:Int {
        let start = self.expenseDate.index(self.expenseDate.startIndex, offsetBy:10)
        let end = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 12)
        let range = start..<end
        
        let mySubstring = self.expenseDate[range]
        let shour:String = String(mySubstring)
        let ihour = Int(shour) ?? 0
        return ihour
    }

    public var internalExpenseMinute:Int {
        let start = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 12)
        let end = self.expenseDate.index(self.expenseDate.startIndex, offsetBy: 14)
        let range = start..<end
        
        let mySubstring = self.expenseDate[range]
        let sminute:String = String(mySubstring)
        let iminute = Int(sminute) ?? 0
        return iminute
    }
    
    public var internalFuelAmount:Double {
        let amount:Double = Double.init(self.expenseFuel) ?? 0.0
        return amount
    }
    
    public var internalMileage:Int {
        let miles:Int = Int.init(self.expenseMiles) ?? 0
        return miles
    }
    
    public var internalExpenseCost:Double {
        let cost:Double = Double.init(self.expenseCost) ?? 0.0
        return cost
    }
}
