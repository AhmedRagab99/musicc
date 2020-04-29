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
class SearchTracks: UITableViewController,UISearchBarDelegate {
    
    
    //MARK:- IBOutlets and IBAActions
    var searchController = UISearchController()
    var searchArray :[SearchDatum] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
       fetchTracks(searchTerm: "sia")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        self.tableView.estimatedRowHeight =
        //        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    
    //MARK:- SetupFunc
    
    fileprivate func setupTableView(){
        tableView.register(UINib(nibName: CellID.SearchCell, bundle: nil), forCellReuseIdentifier: CellID.SearchCell)
    }
    
    func showIndicator(withTitle title: String, and Description:String) {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.show(animated: true)
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    fileprivate func setupNavBar (){
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    var timer:Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self](timer) in
            self?.fetchTracks(searchTerm: searchText)
        })
    }
    
    fileprivate func fetchTracks(searchTerm:String){
        Api.shared.search(let: searchTerm) { [weak self](result, error) in
            if error == nil{
                guard let data = result?.data else {return}
                self?.searchArray = data
                self?.tableView.reloadData()
            }else {
                
                print(error?.localizedDescription)
            }
            
        }
    }
    
    
    
    //MARK:- TableViewFunctions
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a Search Term"
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // ternary operator
        return self.searchArray.isEmpty && searchController.searchBar.text?.isEmpty == true ? 300 : 0
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//         let activityIndicator = UIActivityIndicatorView(style: .large)
//        activityIndicator.color = .systemPink
//        activityIndicator.sta
//        return activityIndicator
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Track = self.searchArray[indexPath.item]
        
        
        let playerDetailsView = PlayerDetailView.initFromNib()
        playerDetailsView.track = Track
        
        playerDetailsView.modalPresentationStyle = .fullScreen
        self.present(playerDetailsView, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellID.SearchCell, for: indexPath) as? SearchCell{
            let track = searchArray[indexPath.row]
            cell.track = track
            
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
}



