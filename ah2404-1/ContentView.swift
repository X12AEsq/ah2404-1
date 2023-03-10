//
//  ContentView.swift
//  ah2404-1
//
//  Created by Morris Albers on 2/24/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var showingEditVehicleView = false
    
    @EnvironmentObject var CVModel:CommonViewModel
 
//    @FirestoreQuery(collectionPath: "vehicles", predicates: []) var vehicles: [Vehicle]
    
//    @Binding var loggedIn: Bool

    var body: some View {
        Group {
            if CVModel.userSession != nil {
                MainInterfaceView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            CVModel.vehicleSubscribe()
            CVModel.expenseSubscribe()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
