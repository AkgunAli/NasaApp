//
//  APIService.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import Alamofire
import Foundation
import Kingfisher
import ObjectMapper

class APIService {
    static var apiService = APIService()

    func loadingBar(status: Bool) {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        var view: UIView
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            view = topController.view

            let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            if status {
                indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                indicator.tag = 1
                indicator.center = view.center
                view.addSubview(indicator)
                view.bringSubviewToFront(indicator)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                indicator.startAnimating()
            } else {
                if let viewWithTag = view.viewWithTag(1) {
                    viewWithTag.removeFromSuperview()
                }
                indicator.stopAnimating()
            }
        }
    }

    func requestGet<T: Mappable>(_ url: URL, _ parameters: [String: Any] = [:], _ method: HTTPMethod = .get, _ httpHeaders: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, success: @escaping (T) -> Void, failure: @escaping () -> Void) {
        loadingBar(status: true)
        let url = url
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        AF.request(request)
            .responseJSON { [self] response in
                loadingBar(status: false)
                if let res = response.value {
                    let json = res as! [String: Any]
                    if let object = Mapper<T>().map(JSON: json) {
                        success(object)
                        return
                    }
                } else if let _ = response.error {
                    failure()
                }
                loadingBar(status: false)
            }
    }

    func downloadImage(with urlString: String, imageCompletionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            return imageCompletionHandler(nil)
        }
        loadingBar(status: true)

        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case let .success(value):
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(nil)
            }
        }
        loadingBar(status: false)

    }
}
