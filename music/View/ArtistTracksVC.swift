//
//  ArtistTracksVC.swift
//  music
//
//  Created by Ahmed Ragab on 6/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class ArtistTracksVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var artistImage: UIImageView!{
        didSet{
            artistImage.layer.cornerRadius = 25
            
            if let url = URL(string: imagePath ?? ""){
                artistImage.kf.indicatorType = .activity
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
                artistImage.kf.setImage(with: .network(url), options: options)
                
            }
        }
    }
    
    @IBOutlet weak var backGroundImage: UIImageView!{
        didSet{
            
            if let url = URL(string: imagePath ?? ""){
                backGroundImage.kf.indicatorType = .activity
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
                backGroundImage.kf.setImage(with: .network(url), options: options)
                
            }
        }
    }
    var imagePath:String?
    var artistId:Int?
    var topTracks:[SearchDatum]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchArtistTopTracks(artistId: artistId ?? 0)

    }
    
    static func ArtistTrackInitNib(artistId:Int,image:String) -> ArtistTracksVC {
        let player = ArtistTracksVC(nibName:XIBS.ArtistTracksVC, bundle: nil)
        player.imagePath = image
        player.artistId = artistId
        return player
    }
    
    
    
    fileprivate func fetchArtistTopTracks(artistId:Int){
        Api.shared.getArtistTopTracks(artistId: artistId) { [weak self] (track, error) in
            guard let self = self else{return}
            
            if(error == nil){
                self.topTracks = track?.data
                print(self.topTracks)
                self.tableView.reloadData()
            }
        }
        
    }
    
    fileprivate func setupTableView(){
           tableView.delegate = self
           tableView.dataSource = self
           self.tableView.register(UINib(nibName: CellID.SearchCell, bundle: nil), forCellReuseIdentifier: CellID.SearchCell)
       }
  
}

extension ArtistTracksVC:UITableViewDelegate,UITableViewDataSource{
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
