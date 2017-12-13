//
//  Weather.swift
//  testNiblsoft
//
//  Created by Руслан on 12.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var location: LocationData
    var current: CurrentData
}
struct LocationData: Codable {
   var country : String?
   var region : String?
   var lat : Double?
   var lon : Double?
   var localtime : String?
}

struct CurrentData: Codable {
  var temp_c : Double
  var condition: ConditionData
}

struct ConditionData: Codable {
  var icon : String
}


