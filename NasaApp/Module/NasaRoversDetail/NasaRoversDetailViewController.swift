//
//  NasaRoversDetailViewController.swift
//  NasaApp
//
//  Created by skylanddev1 on 17.05.2021.
//

import UIKit

class NasaRoversDetailViewController: UIViewController {
    @IBOutlet var roverImage: UIImageView!
    @IBOutlet var roverName: UILabel!
    @IBOutlet var roverDate: UILabel!
    @IBOutlet var roverCamera: UILabel!
    @IBOutlet var roverStatus: UILabel!
    @IBOutlet var roverLaunchDate: UILabel!
    @IBOutlet var roverLandingDate: UILabel!

    var roverImageD = UIImage()
    var roverNameD = ""
    var roverDateD = ""
    var roverCameraD = ""
    var roverStatusD = ""
    var roverLaunchDateD = ""
    var roverLandingDateD = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        roverName.text = roverNameD
        roverDate.text = roverDateD
        roverCamera.text = roverCameraD // full_name
        roverStatus.text = roverStatusD
        roverLaunchDate.text = roverLaunchDateD
        roverLandingDate.text = roverLandingDateD
        roverImage.image = roverImageD
    }

    @IBAction func dismissDialog(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
