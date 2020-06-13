//
//  ArtistDetailVC.swift
//  music
//
//  Created by Ahmed Ragab on 6/13/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class TopChartsVC: UIViewController {
    
    var genereId:Int?
    var topTracks:[SearchDatum]?
    var imageUrl:String?
    
    var selectedButton:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharts(genereId: genereId ?? 0)
        
        setupTableView()
        
        
    }
    
    
    
    //MARK:- setup Functions
    static func ArtistinitFromNib(generId:Int,image:String) -> TopChartsVC {
        let player = TopChartsVC(nibName:XIBS.ArtistDetailVC, bundle: nil)
        player.genereId = generId
        player.imageUrl = image
        return player
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: CellID.SearchCell, bundle: nil), forCellReuseIdentifier: CellID.SearchCell)
    }
    
    fileprivate func fetchCharts(genereId:Int){
        Api.shared.getTopCharts(genreId: genereId) { [weak self](chart, error) in
            guard let self = self else{return}
            self.topTracks = chart?.data
            self.tableView.reloadData()
            print(self.topTracks)
            //  print(self.topTracks?[2].artist?.picture)
        }
    }
    
    
    
    //MARK: Outlets and IBActions
    
    @IBOutlet weak var genereImageView: UIImageView!{
        didSet{
            genereImageView.layer.cornerRadius = 25
            
            if let url = URL(string: imageUrl ?? ""){
                genereImageView.kf.indicatorType = .activity
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
                genereImageView.kf.setImage(with: .network(url), options: options)
                
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
}


extension TopChartsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.SearchCell, for: indexPath) as? SearchCell , let track = topTracks?[indexPath.row] else{ return UITableViewCell()}
        cell.album = track
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let track = self.topTracks?[indexPath.row] else{return}
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let mainTabBar = keyWindow?.rootViewController as? MainTabBar
        mainTabBar?.maximizeDetailView(track: track)
    }
    
    
}
