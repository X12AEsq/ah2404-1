//
//  EditExpenseView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI

struct EditExpenseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var CVModel:CommonViewModel

    var vehicle:Vehicle
    var expense:Expense?
    
    let expTypes = ExpenseCategories()
    
//    let integerFormatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
    
    @State var expenseIntDate:Date = Date()
    @State var expenseDate:[String] = ["", "", ""]
    @State var expenseDateYear:String = ""
    @State var expenseDateMonth:String = ""
    @State var expenseDateDay:String = ""
    @State var expenseDateString:String = ""
    @State var expenseTimeString:String = ""

    @State private var editing:Bool = false
    @State private var saveMessage = ""
    @State private var expenseHeading = ""
    @State private var editMessage = ""
    @State private var expenseType = ""
    @State private var expdate = ""
    @State private var expvehicle = ""
    @State private var expenseFuel = "" // fuel in gallons
    @State private var expmiles = ""
    @State private var expdescr = ""
    @State private var expcost = ""

    var body: some View {
        VStack(alignment:.leading) {
            VStack(alignment:.leading) {
                Text(expenseHeading)
                    .font(.largeTitle.bold())
                HStack {
                    Text("for:")
                    Text(vehicle.formattedVehicle)
                }
                if editMessage != "" {
                    Text(editMessage)
                        .foregroundColor(.red)
                }
            }
            VStack(alignment:.leading) {
                HStack {
                    Text("Expense Date")
                    DatePicker("XX", selection: $expenseIntDate).padding().onChange(of: expenseIntDate, perform: { value in
                        expenseDateString = DateService.dateExt2Int(inDate: value)
                        populateDates()
                        print("Date: \(expenseDateString) \(expenseTimeString) \(expenseIntDate)")
                    })
                }
                HStack {
                    Text("Expense Type")
                    Picker("Expense Type", selection: $expenseType) {
                        ForEach(expTypes.ExpenseCategoryOptions, id: \.self) {
                            Text($0).tag(Optional($0))
                        }
                    }
                }
                HStack {
                    Text("Expense Miles")
                    TextField(text: $expmiles, prompt: Text("mileage")) {
                        Text(expmiles).tag(Optional<String>(nil))
                    }
                    .onSubmit {
                        let worklist = FormattingService.deComposeNumber(inpnumber:expmiles)
                        expmiles = FormattingService.formatNumber(inpnumber: worklist, decimals: 0)
                    }
                }
            }
            VStack(alignment:.leading) {
                if expenseType == "Fuel" {
                    HStack {
                        Text("Expense Fuel")
                        TextField(text: $expenseFuel, prompt: Text("gallons")) {
                            Text(expenseFuel).tag(Optional<String>(nil))
                        }
                        .onSubmit {
                            print(expenseFuel)
                            let worklist = FormattingService.deComposeNumber(inpnumber:expenseFuel)
                            expenseFuel = FormattingService.formatNumber(inpnumber: worklist, decimals: 3)
                        }
                    }
                }
                HStack {
                    Text("Expense Cost")
                    TextField(text: $expcost, prompt: Text("cost")) {
                        Text(expcost).tag(Optional<String>(nil))
                    }
                    .onSubmit {
                        let worklist = FormattingService.deComposeNumber(inpnumber:expcost)
                        expcost = FormattingService.formatNumber(inpnumber: worklist, decimals: 2)
                    }
                }
                HStack {
                    Text("Expense Description")
                    TextField(text: $expdescr, prompt: Text("description")) {
                        Text(expdescr).tag(Optional<String>(nil))
                    }
                }
                Button {
                    let recordStatus = editExpenseRecord()
                    if recordStatus {
                        RecordData()
                        if editing {
                            print("Editing")
                        } else {
                            print("Saving")
                        }
                    }
                } label: {
                    Text(saveMessage)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.red.opacity(0.3), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
                .buttonStyle(CustomButton())
            }

            Spacer()
        }
        .padding(.leading, 20.0)
        .onAppear {
            if let expense = expense {
                expdate = expense.expenseDate
                expenseIntDate = expense.internalExpenseDate
                expenseHeading = "Edit Expense"
                expenseType = expense.expenseType
                expenseFuel = expense.expenseFuel
                expmiles = expense.expenseMiles
                expdescr = expense.expenseDescr
                expcost = expense.expenseCost
                editing = true
                saveMessage = "Update"
            } else {
                expenseHeading = "New Expense"
                expdate = ""
                expenseIntDate = Date()
                populateDates()
                print("Date: \(expenseDateString) \(expenseTimeString) \(expenseIntDate)")
                expenseType = expTypes.ExpenseCategoryOptions[0]
                expvehicle = vehicle.nickname
                expenseFuel = ""
                expmiles = ""
                expdescr = ""
                expcost = ""
                editing = false
                saveMessage = "Add"
            }
        }
    }
/*
 (lldb) po expenseData
 ▿ 7 elements
   ▿ 0 : 2 elements
     - key : "vehicle"
     - value : "Sub"
   ▿ 1 : 2 elements
     - key : "expenseMiles"
     - value : ""
   ▿ 2 : 2 elements
     - key : "expenseFuel"
     - value : ""
   ▿ 3 : 2 elements
     - key : "expenseDate"
     - value : "20230222, 2148"
   ▿ 4 : 2 elements
     - key : "expenseType"
     - value : "Fuel"
   ▿ 5 : 2 elements
     - key : "expenseCost"
     - value : ""
   ▿ 6 : 2 elements
     - key : "expenseDescr"
     - value : ""
 
    RecordData() has not been invoked yet when editExpenseRecord() is called
*/
    func editExpenseRecord() -> Bool {
        editMessage = ""
        if expenseDateString == "" || expenseTimeString == "" {
            editMessage = "Date " + expenseDateString + ", " + expenseTimeString + " is invalid"
            return false
        } else {
            expdate = expenseDateString + ", " + expenseTimeString
            print(expenseDateString, expenseTimeString, expdate)
        }
        if expenseType == "Fuel" {
            if expenseFuel == "" {
                editMessage = "If reporting fueling, must enter amount of fuel"
                return false
            }
        }
        if expmiles == "" || Int(expmiles) == nil || Int(expmiles) == 0 {
            editMessage = "Mileage must not be blank or zero"
            return false
        }
        if expcost == "" {
            editMessage = "Cost must not be blank"
            return false
        }
        return true
    }
    
    func populateDates() -> Void {
        let workDate:[String] = DateService.splitDateTime(inDate: expenseIntDate)
        expenseDateYear = workDate[0]
        expenseDateMonth = workDate[1]
        expenseDateDay = workDate[2]
        expenseDateString = workDate[7]
        expenseTimeString = workDate[6]
    }
/*
    RecordData is called after the input data has been edited
*/
    func RecordData() {
        let expenseData: [String:Any] = [
            "vehicle":expvehicle,
            "expenseDate":expdate,
            "expenseMiles":expmiles,
            "expenseType":expenseType,
            "expenseFuel":expenseFuel,
            "expenseDescr":expdescr,
            "expenseCost":expcost
        ]
        
        if let expense = expense {
            // Update
            print(expenseData)
            guard let expenseID = expense.id else {
                return
            }
            
//            Task {
//                await CVModel.updateVehicle(vehicleID: vehicleID, vehicleData: vehicleData)
//                if CVModel.taskCompleted {
//                    dismiss()
//                }
//            }
        } else {
            print(expenseData)
            // Add
            Task {
                await CVModel.addExpense(expenseData: expenseData)
                if CVModel.taskCompleted {
                    dismiss()
                }
            }
        }
    }

}

//struct EditExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExpenseView()
//    }
//}
