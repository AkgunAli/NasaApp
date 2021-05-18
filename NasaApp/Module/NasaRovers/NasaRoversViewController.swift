//
//  NasaRoversViewController.swift
//  NasaApp
//
//  Created by skylanddev1 on 15.05.2021.
//

import UIKit

class NasaRoversViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var page: Int = 1
    var isPageRefreshing: Bool = false

    lazy var viewModel: NasaRoversViewModel = {
        NasaRoversViewModel()
    }()

    let roversCellIdentifier = "NasaRoversCollectionViewCell"
    var currentTab = curiosity

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibRowCell = UINib(nibName: roversCellIdentifier, bundle: nil)
        collectionView.register(nibRowCell, forCellWithReuseIdentifier: roversCellIdentifier)
        initView()
        initVM()
    }

    func initView() {
        navigationItem.title = "Nasa Rovers "
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter-filled"), style: .done, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func addTapped() {
        viewModel.pickerViewShow(UIViewController: self)
    }

    func initVM() {
        viewModel.initFetch(roverType: curiosity, page: "\(page)")
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    @IBAction func curiosityTab(_ sender: Any) {
        page = 1
        viewModel.initFetch(roverType: curiosity, page: "\(page)")
        currentTab = curiosity
    }

    @IBAction func opportunityTab(_ sender: Any) {
        page = 1
        viewModel.initFetch(roverType: opportunity, page: "\(page)")
        currentTab = opportunity
    }

    @IBAction func spiritTab(_ sender: Any) {
        page = 1
        viewModel.initFetch(roverType: spirit, page: "\(page)")
        currentTab = spirit
    }
}

extension NasaRoversViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roversCellIdentifier, for: indexPath as IndexPath) as! NasaRoversCollectionViewCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.roversPhotoCellViewModel = cellVM

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userPressed(at: indexPath, UIViewController: self)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height) - 100 {
            if !isPageRefreshing {
                isPageRefreshing = true
                page = page + 1
                if currentTab == curiosity {
                    viewModel.initFetch(roverType: curiosity, page: "\(page)")
                } else if currentTab == opportunity {
                    viewModel.initFetch(roverType: opportunity, page: "\(page)")

                } else {
                    viewModel.initFetch(roverType: spirit, page: "\(page)")
                }
            }
            viewModel.reloadTableViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                if self!.viewModel.countResponse > 0 {
                    self!.isPageRefreshing = false
                }
            }
        }
    }
}

extension NasaRoversViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.uniquePickerArray!.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.uniquePickerArray![row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.pickerSelectedValue = viewModel.uniquePickerArray?[row] ?? ""
    }
}
