//
//  SelectVehicleView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct SelectVehicleView: View {
    @EnvironmentObject var CVModel:CommonViewModel
 
 //   @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]

    var body: some View {
        NavigationStack {
            List {
                ForEach(CVModel.vehicles) { vehicle in
                    NavigationLink(vehicle.formattedVehicle) {
                        ExpenseContentView(vehicle: vehicle)
                    }
                }
             }
            .listStyle(.plain)
            .navigationTitle("Select")
        }
        .onAppear {
            print("SelectVehicleView appears")
        }
    }
}

//struct SelectVehicleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectVehicleView()
//    }
//}
