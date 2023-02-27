//
//  VehicleContentView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct VehicleContentView: View {
    @State private var showingEditVehicleView = false
    
    @EnvironmentObject var CVModel:CommonViewModel
 
//    @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]
    
    var body: some View {
        // TODO: Replace with navigation stack
        NavigationStack {
            List {
                ForEach(CVModel.vehicles) { vehicle in
                    NavigationLink(vehicle.formattedVehicle) {
                        EditVehicleView(vehicle: vehicle)
                    }
                }
                .onDelete(perform: delete)
                NavigationLink(destination: { EditVehicleView() }, label: { Text("Add New Vehicle") })
            }
            .listStyle(.plain)
            .navigationTitle("Vehicle?")
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let vehicle = CVModel.vehicles[index]
            Task {
                await CVModel.deleteVehicle(vehicle:vehicle)
            }
        }
    }
}
