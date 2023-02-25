//
//  DetailVehicleView.swift
//  ah2404
//
//  Created by Morris Albers on 2/19/23.
//

import SwiftUI
import FirebaseFirestore

struct DetailVehicleView: View {
    
    let vehicle: Vehicle
    
    @State private var showingEditVehicleView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VehicleRow(label: "NickName", value: vehicle.nickname)
                VehicleRow(label: "Make", value: vehicle.make)
                VehicleRow(label: "Model", value: vehicle.model)
            }
        }
        .navigationTitle(vehicle.nickname)
/*
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingEditVehicleView = true
                } label : {
                    Text("Update")
                }
            }
        }
 */
        .sheet(isPresented: $showingEditVehicleView) {
            EditVehicleView(vehicle: vehicle)
        }
    }
}

//struct DetailVehicleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailVehicleView()
//    }
//}

struct VehicleRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            Text(label)
            Text(value).bold()
            Spacer()
        }
        .font(.body)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color(.cyan), in: RoundedRectangle(cornerRadius: 15, style:.continuous))
    }
}
