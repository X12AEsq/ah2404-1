//
//  Expense.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Expense: Identifiable, Codable, ObservableObject {
    
    @DocumentID var id: String?
    var vehicle:String
    var expenseDate:String
    var expenseMiles: String
    var expenseType:String
    var expenseFuel:String
    var expenseDescr:String
    var expenseCost:String
    
    init() {
        self.id = ""
        self.vehicle = ""
        self.expenseDate = ""
        self.expenseType = ""
        self.expenseFuel = ""
        self.expenseMiles = ""
        self.expenseDescr = ""
        self.expenseCost = ""
    }
    
    init (fsid:String, expenseDate:String, vehicle:String, expenseType:String, amount:String, miles:String, descr:String, cost:String) {
        self.id = fsid
        self.vehicle = vehicle
        self.expenseDate = expenseDate
        self.expenseType = expenseType
        self.expenseFuel = amount
        self.expenseMiles = miles
        self.expenseDescr = descr
        self.expenseCost = cost
    }
}
