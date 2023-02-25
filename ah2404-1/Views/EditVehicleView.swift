//
//  EditVehicleView.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import SwiftUI

struct EditVehicleView: View {
    
    @State private var nickname = ""
    @State private var make = ""
    @State private var model = ""
    @State private var year = 0
    @State private var initialMiles = 0
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var CVModel:CommonViewModel
    
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .none
        return nf
    }()

    var vehicle:Vehicle?
    
    var vehicleHeading: String {
        if let _ = vehicle {
            return "Edit Vehicle"
        } else {
            return "Add Vehicle"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(vehicleHeading)
                    .font(.largeTitle.bold())
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(.yellow)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                }
            }
            .padding(.vertical, 30)
        }
        
        Spacer()
        
        VStack(spacing: 20) {
//            VStack(alignment:.leading) {
            HStack {
                Text("nickname:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter nickname", text: $nickname)
                    .textFieldStyle(.roundedBorder)
            }
//            VStack(alignment:.leading) {
            HStack {
                Text("make:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter make", text: $make)
                    .textFieldStyle(.roundedBorder)
            }
//            VStack(alignment:.leading) {
            HStack {
                Text("model:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter model", text: $model)
                    .textFieldStyle(.roundedBorder)
            }
//            VStack(alignment:.leading) {
            HStack {
                Text("year:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter year", value: $year, formatter: numberFormatter)
                    .textFieldStyle(.roundedBorder)
            }
//            VStack(alignment:.leading) {
            HStack {
                Text("starting mileage:")
                    .foregroundColor(.green)
                    .opacity(0.6)
                TextField("Enter mileage", value: $initialMiles, format: .number)
                    .textFieldStyle(.roundedBorder)
            }

            Spacer()
            
            Button {
                EditData()
            } label: {
                Text(vehicleHeading)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            if let vehicle = vehicle {
                nickname = vehicle.nickname
                make = vehicle.make
                model = vehicle.model
                year = vehicle.year
                initialMiles = vehicle.initialMiles
            }
        }
    }
    
    func EditData() {
        let vehicleData: [String:Any] = [
            "nickname":nickname,
            "make":make,
            "model":model,
            "year":year,
            "initialMiles":initialMiles
        ]
        
        if let vehicle = vehicle {
            // Update
            guard let vehicleID = vehicle.id else {
                return
            }
            
            Task {
                await CVModel.updateVehicle(vehicleID: vehicleID, vehicleData: vehicleData)
                if CVModel.taskCompleted {
                    dismiss()
                }
            }
        } else {
            // Add
            Task {
                await CVModel.addVehicle(vehicleData: vehicleData)
                if CVModel.taskCompleted {
                    dismiss()
                }
            }
        }
    }
}

//struct EditVehicleView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditVehicleView()
//    }
//}
