//
//  ah2404_1App.swift
//  ah2404-1
//
//  Created by Morris Albers on 2/24/23.
//

import SwiftUI
import FirebaseCore

@available(iOS 15.0, *)

@main
struct ah2404_1App: App {
    
    @StateObject var CVModel = CommonViewModel()
    
    init() {
        FirebaseApp.configure()

    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CVModel)
        }
    }
}
