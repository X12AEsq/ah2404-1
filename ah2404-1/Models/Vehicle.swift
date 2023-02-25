//
//  Vehicle.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Vehicle: Identifiable, Codable, ObservableObject {
    @DocumentID var id: String?
    var nickname: String
    var make:String
    var model:String
    var year:Int
    var initialMiles:Int

    init() {
        self.id = ""
        self.nickname = ""
        self.make = ""
        self.model = ""
        self.year = 0
        self.initialMiles = 0
    }
    
    init (fsid:String, nickname:String, make:String, model:String, year:Int, initialMiles:Int) {
        self.id = fsid
        self.nickname = nickname
        self.make = make
        self.model = model
        self.year = year
        self.initialMiles = initialMiles
    }
}
