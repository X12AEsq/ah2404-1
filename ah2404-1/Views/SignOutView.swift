//
//  SignOutView.swift
//  ah2404
//
//  Created by Morris Albers on 2/20/23.
//
import SwiftUI
import FirebaseAuth

@available(iOS 15.0, *)
struct SignOutView: View {
    @EnvironmentObject var CVModel:CommonViewModel

    var body: some View {
        Group {
            if CVModel.signout() {
                LoginView()
            } else {
                Text("Signout failed")
            }
        }
    }
}
