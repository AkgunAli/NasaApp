//
//  NasaRoversDetailViewController.swift
//  NasaApp
//
//  Created by skylanddev1 on 17.05.2021.
//

import UIKit

class NasaRoversDetailViewController: UIViewController {

    @IBOutlet weak var roverImage: UIImageView!
    @IBOutlet weak var roverName: UILabel!
    @IBOutlet weak var roverDate: UILabel!
    @IBOutlet weak var roverCamera: UILabel!
    @IBOutlet weak var roverStatus: UILabel!
    @IBOutlet weak var roverLaunchDate: UILabel!
    @IBOutlet weak var roverLandingDate: UILabel!

    var roverImageD = UIImage()
    var roverNameD = ""
    var roverDateD  = ""
    var roverCameraD = ""
    var roverStatusD = ""
    var roverLaunchDateD = ""
    var roverLandingDateD = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.roverName.text = self.roverNameD
        self.roverDate.text = self.roverDateD
        self.roverCamera.text = self.roverCameraD    // full_name
        self.roverStatus.text = self.roverStatusD
        self.roverLaunchDate.text =  self.roverLaunchDateD
        self.roverLandingDate.text =  self.roverLandingDateD
        self.roverImage.image = roverImageD

        
    }
    

   
    @IBAction func dismissDialog(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
