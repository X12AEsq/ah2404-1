//
//  ExpenseContentView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct ExpenseContentView: View {
    var vehicle:Vehicle
    
    @State private var showingEditVehicleView = false
    
    @EnvironmentObject var CVModel:CommonViewModel
 
//    @FirestoreQuery(collectionPath: "expenses", predicates: []) var expenses: [Expense]

    var body: some View {
        NavigationStack {
            List {
                ForEach(CVModel.expensesSorted) { expense in
                    if expense.vehicle == vehicle.nickname {
                        NavigationLink {
                            EditExpenseView(vehicle: vehicle, expense: expense)
                        } label: {
                            HStack(alignment:.center) {
                                VStack(alignment:.leading) {
                                    HStack {
                                        Text(expense.expenseDate)
                                        Text("-")
                                        Text(expense.expenseType)
                                    }
                                }
                            }
//                            explabel(expenseDate: expense.expenseDate)
                        }
                    }
                }
                .listStyle(.plain)
                NavigationLink(destination: { EditExpenseView(vehicle: vehicle) }, label: { Text("New Expense") })
            }
            .navigationTitle("Expense?").fontWeight(.regular)
//            .onAppear {
//                print("ExpenseContentView Link appeared", CVModel.expenses)
//            }
        }
        .onAppear {
            print("ExpenseContentView appeared", CVModel.expenses)
        }
    }
}

//struct explabel: View {
//    var expenseDate:String
//
//    var body: some View {
//        HStack(alignment:.center) {
//            VStack(alignment:.leading) {
//                Text(expenseDate)
//                    .font(.headline)
//            }
//        }
//    }
//}


//struct ExpenseContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseContentView()
//    }
//}
