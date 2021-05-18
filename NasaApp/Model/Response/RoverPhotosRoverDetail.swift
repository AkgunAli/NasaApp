//
//  RoverPhotosRoverDetail.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import Foundation
import ObjectMapper

class RoverPhotosRoverDetail: Mappable {
    var id: Int?
    var name: String?
    
    var landing_date: String?
    var launch_date: String?
    var status: String?

    required init(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        landing_date <- map["landing_date"]
        launch_date <- map["launch_date"]
        status <- map["status"]

    }
}
