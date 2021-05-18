//
//  RoversBase.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import Foundation
import ObjectMapper

class RoversBase: Mappable {
    var photos: [RoversPhotos]?

    required init(map: Map) {
    }

    func mapping(map: Map) {
        photos <- map["photos"]
    }
}
