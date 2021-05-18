//
//  NasaRoversViewModel.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import Alamofire
import Foundation

class NasaRoversViewModel {
    var apiService = APIService()
    private var rovers: [RoversPhotos] = [RoversPhotos]()
    var filteredRovers: [RoversPhotos] = [RoversPhotos]()
    var uniquePickerArray : [String]?
    var reloadTableViewClosure: (() -> Void)?
    var countResponse = 0
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var pickerSelectedValue  = ""

    func initFetch(roverType: String, page: String) {
        var urlComponents = URLComponents(string: baseURL + roverType + "/photos")!
        urlComponents.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: page),
        ]
        print("urlComponents.url!", urlComponents.url!)

        apiService.requestGet(urlComponents.url!, [:], encoding: URLEncoding.default, success: { [self]
            (response: RoversBase) in
            print("response.photos?.count geldi", response.photos?.count)
            countResponse = response.photos?.count ?? 0
            // self.rovers = response.photos!
            if page != "1" {
                processFetchedPhoto(roversResult: response.photos! + rovers)

            } else {
                processFetchedPhoto(roversResult: response.photos!)
                filteredRovers = response.photos!

            }
            filteredPickerValue()
        },
        failure: {
            print("response.photos gelmedi")

        })
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }
    func filteredPickerValue( ) {
        var unique = [String]()
        for item in filteredRovers {
        unique.append( (item.camera?.name)!)
        }
        uniquePickerArray = Array(Set(unique))
    }

    private var cellViewModels: [roversPhotoCellViewModel] = [roversPhotoCellViewModel]() {
        didSet {
            reloadTableViewClosure?()
        }
    }

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func getCellViewModel(at indexPath: IndexPath) -> roversPhotoCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func createCellViewModel(rovers: RoversPhotos) -> roversPhotoCellViewModel {
        let desc = rovers.camera?.full_name ?? ""
        let imageURL = rovers.img_src ?? ""

        return roversPhotoCellViewModel(titleText: desc, imageUrl: imageURL)
    }

    private func processFetchedPhoto(roversResult: [RoversPhotos]) {
        rovers = roversResult // Cache
        var vms = [roversPhotoCellViewModel]()
        for photo in rovers {
            vms.append(createCellViewModel(rovers: photo))
        }
        cellViewModels = vms
    }
}

extension NasaRoversViewModel {
    func userPressed(at indexPath: IndexPath, UIViewController: UIViewController) {
        let roversDetail = rovers[indexPath.row]
        let NasaRoversDetailVC = UIStoryboard(name: "Main", bundle: nil)
        let alertVC = NasaRoversDetailVC.instantiateViewController(identifier: "NasaRoversDetailViewController") as! NasaRoversDetailViewController
        alertVC.modalPresentationStyle = .overCurrentContext
        
        apiService.downloadImage(with : roversDetail.img_src!){ image in
             guard let image  = image else { return}
            alertVC.roverImageD = image

         }
        alertVC.roverNameD = roversDetail.rover?.name ?? ""
        alertVC.roverDateD = roversDetail.earth_date ?? ""
        alertVC.roverCameraD = roversDetail.camera?.name   ?? ""  // full_name
        alertVC.roverStatusD = roversDetail.rover?.status ?? ""
        alertVC.roverLaunchDateD = roversDetail.rover?.launch_date ?? ""
        alertVC.roverLandingDateD = roversDetail.rover?.landing_date ?? ""

    

        UIViewController.present(alertVC, animated: true, completion: nil)
    }
    
    func pickerViewShow ( UIViewController: UIViewController) {
        picker = UIPickerView.init()
        picker.delegate = UIViewController.self as? UIPickerViewDelegate
        picker.dataSource = UIViewController.self as? UIPickerViewDataSource
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        UIViewController.view.addSubview(picker)
                
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        UIViewController.view.addSubview(toolBar)
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        print("done butonu çalıştı vavlue : " , pickerSelectedValue)
        filterRovers(filteredValue: pickerSelectedValue)
    }
    
    func filterRovers(filteredValue : String) {
        let filterArray = filteredRovers.filter { obj  in
            return (obj.camera?.name!.lowercased().contains(filteredValue.lowercased()))!
            }
        
        for item in filterArray {
            print("item.camera?.name geldi " , item.camera?.name)
        }
        
        processFetchedPhoto(roversResult: filterArray)


    }
}



struct roversPhotoCellViewModel {
    let titleText: String
    let imageUrl: String
}
