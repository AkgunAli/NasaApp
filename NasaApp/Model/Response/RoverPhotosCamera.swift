//
//  RoverPhotosCamera.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import Foundation
import ObjectMapper

class RoverPhotosCamera: Mappable {
    var id: Int?
    var name: String?
    var rover_id: Int?
    var full_name: String?

    required init(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        rover_id <- map["rover_id"]
        full_name <- map["full_name"]
    }
}
