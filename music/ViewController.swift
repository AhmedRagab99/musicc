//
//  ViewController.swift
//  music
//
//  Created by Ahmed Ragab on 4/18/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Alamofire
import Lottie
import MBProgressHUD
import Kingfisher
class ViewController: UITableViewController,UISearchBarDelegate {

    
    //MARK:- IBOutlets and IBAActions
    var searchController = UISearchController()
    var searchArray :[SearchDatum]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupNavBar()
        setupTableView()
        }
    
    
    
    fileprivate func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID.serachCell)
    }
    
    
    fileprivate func setupNavBar (){
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "search track"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    var timer:Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            self.fetchTracks(searchTerm: searchText)
        })
    }
    
    fileprivate func fetchTracks(searchTerm:String){
        Api.shared.search(let: searchTerm) { (result, error) in
            self.searchArray = result?.data
            self.tableView.reloadData()
        }
    }
    
    
    
    //MARK:- TableViewFunc
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let label = UILabel()
          label.text = "Please enter a Search Term"
          label.textAlignment = .center
          label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
          return label
      }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // ternary operator
        return self.searchArray?.isEmpty ?? false && searchController.searchBar.text?.isEmpty == true ? 250 : 0
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.serachCell, for: indexPath)
        let track = searchArray?[indexPath.row]
        cell.textLabel?.text = track?.title
        let url =  track?.artist?.pictureMedium ?? ""
        
        if let url = URL(string: url){
            cell.imageView?.kf.indicatorType = .activity
                                  let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
            cell.imageView?.kf.setImage(with: .network(url), options: options)
        }
        return cell
    }
    
    }



