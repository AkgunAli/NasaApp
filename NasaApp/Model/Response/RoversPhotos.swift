//
//  RoversPhotos.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import Foundation
import ObjectMapper

class RoversPhotos: Mappable {
    var id : Int?
    var sol : Int?
    var camera : RoverPhotosCamera?
    var img_src : String?
    var earth_date : String?
    var rover : RoverPhotosRoverDetail?

    
    
    required init(map: Map) {
    }

    func mapping(map: Map) {
        id  <- map["id"]
        sol  <- map["sol"]
        camera  <- map["camera"]
        img_src  <- map["img_src"]
        earth_date  <- map["earth_date"]
        rover  <- map["rover"]

    }
}
