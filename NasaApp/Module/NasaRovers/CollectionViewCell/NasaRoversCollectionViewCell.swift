//
//  NasaRoversCollectionViewCell.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import UIKit

class NasaRoversCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roverImage: UIImageView!
    @IBOutlet weak var roverTitle: UILabel!
    var apiService = APIService()

    var roversPhotoCellViewModel : roversPhotoCellViewModel? {
        didSet {
            roverTitle.text = roversPhotoCellViewModel?.titleText
            apiService.downloadImage(with :roversPhotoCellViewModel!.imageUrl){ [self]image in
                 guard let image  = image else { return}
                roverImage.image = image
             }

        }
    }

}
