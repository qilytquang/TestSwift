//
//  HomeViewController.swift
//  Baitap3+4
//
//  Created by ADMIN on 8/12/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = HomeViewModel()
    
    var isSearching: Bool = false
    private var isLoadingMore = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadAPI()
        searchBar.delegate = self
    }
    
    func configTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    func loadAPI() {
        viewModel.loadAPI { [weak self] (done, msg) in
            guard let self = self else { return}
            if done {
                self.viewModel.dataAPISearch = self.viewModel.dataAPI
                self.updateUI()
            } else {
                let alert = UIAlertController(title: "Warning", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil )
            }
        }
    }
}
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? HomeTableViewCell else {return UITableViewCell()}
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        let item = viewModel.dataAPI[indexPath.row]
        viewModel.loadImage(urlString: item.url) { (image) in
            if let image = image {
                cell.configImage(image: image)
            } else {
                cell.configImage(image: nil)
            }
        }
        //print(viewModel.dataAPI[indexPath.row].titleVideo)
//        if isSearching {
//            cell.viewModel?.dataAPI = viewModel.dataAPI[indexPath.row]
//            print(cell.viewModel?.dataAPI)
//        } else {
//            cell.viewModel?.dataAPI = viewModel.dataAPISearch[indexPath.row]
//        }
//        let item = viewModel.dataAPI[indexPath.row]
//        let item2 = viewModel.dataAPISearch[indexPath.row]
//        if isSearching {
//           // cell.viewModel[indexPath.row] = item2
//        } else {
//            item
//        }
        return cell
//        let item = viewModel.dataAPISearch[indexPath.row]
//        viewModel.loadImage(urlString: item.url) { (image) in
//            if let image = image {
//                cell.configImage(image: image)
//            } else {
//                cell.configImage(image: nil)
//            }
//        }
//        return cell
    }
}
//extension HomeViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let upperText = searchText.uppercased()
//        viewModel.titleSearchs = viewModel.titleVideos.filter {
//            $0.uppercased().hasPrefix(upperText)
//        }
//        viewModel.search()
//        tableView.reloadData()
//    }
//}
extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if !isLoadingMore && (maximumOffset - contentOffset <= 100) {
            loadAPI()
            self.isLoadingMore = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.tableView.reloadData()
                self.isLoadingMore = false
            }
        }
    }
}
//extension HomeViewController: UITableViewDataSource {
//
//}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        var searchResult: [DataAPI] = []
//        isSearching = searchText != ""
//        for item in viewModel.dataAPI  {
//            searchResult.append(DataAPI)
//        }
////        viewModel.dataAPI. = searchResult
//        tableView.reloadData()
    }
}
