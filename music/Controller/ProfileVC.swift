//
//  ProfileVC.swift
//  music
//
//  Created by Ahmed Ragab on 6/17/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class ProfileVC: UIViewController {
    
    
    
    var user:User? = nil
    var userTracks:[SearchDatum]?
    var userArtists:[Artist]?
    var tracksState:Bool = true
    var artistsState:Bool = false
    var playlistState:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchUser()
        fetchUserFlow()
        //fetchUserArtist()
       
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        artistCountLabel.text = "\(userArtists?.count ?? 16)"
               userName.text = user?.name ?? "Ahmed Ragab"
               trackCountLabel.text = "\(userTracks?.count ?? 25)"
         playListCountLabel.text = "\(userTracks?.count ?? 4)"
        userImage.layer.cornerRadius = 20
                 let urlString =  user?.picture ?? "https://api.deezer.com/user/2882739824/image"
                              if let url = URL(string: urlString){
                                  userImage.kf.indicatorType = .activity
                                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.3))]
                                  userImage.kf.setImage(with: .network(url), options: options)
                              }
    }
    
    
    //MARK:- setup functions
    
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
   tableView.register(UINib(nibName: CellID.SearchCell, bundle: nil), forCellReuseIdentifier: CellID.SearchCell)
        
    }
    
    
    
    fileprivate func fetchUser(){
        Api.shared.getUser(userId:2882739824) { [weak self] (user, error) in
            guard let self = self else {return}
            if error == nil{
                self.user = user
                print(self.user)
               // self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func fetchUserFlow(){
        Api.shared.getUserTracks(userId:2882739824) { [weak self](track, error) in
            guard let self = self else{return}
            if error == nil {
                self.userTracks = track?.data
                print(self.userTracks)
                self.tableView.reloadData()
            }
        }
    }
    
    
    fileprivate func fetchUserArtist(){
        Api.shared.getUserArtists(userId:2882739824) { [weak self](artist, error) in
            guard let self = self else{return}
            
            if error == nil{
                self.userArtists = artist?.data
                print(self.userArtists)
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK:- outlets and IBActions
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
         
        }
    }
    @IBOutlet weak var userName: UILabel!{
        didSet{
        }
    }
    @IBOutlet weak var artistCountLabel: UILabel!{
        didSet{
        }
    }
    @IBOutlet weak var playListCountLabel: UILabel!{
        didSet{

        }
    }
    @IBOutlet weak var trackCountLabel: UILabel!{
        didSet{
            trackCountLabel.text = "\(userTracks?.count ?? 0)"

        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func TrackButtonClicked(_ sender: Any) {
      
          self.tracksState = false
            self.artistsState = false
            self.playlistState = false
        
    }
    
    @IBAction func ArtistButtonClicked(_ sender: Any) {
               self.artistsState = true
                   self.tracksState = false
                   self.playlistState = false
    }
    
    @IBAction func PlayListButtonClicked(_ sender: Any) {
        self.artistsState = false
        self.tracksState = false
        self.playlistState = true
    }
    
}

extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return userTracks?.count ?? 0
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.SearchCell, for: indexPath) as? SearchCell else{return UITableViewCell()}
        
            guard let track = userTracks?[indexPath.row] else {return UITableViewCell()}
            cell.track = track
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Track = self.userTracks?[indexPath.item]
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let mainTabBar = keyWindow?.rootViewController as? MainTabBar
            mainTabBar?.maximizeDetailView(track: Track)
    }
    
    
    
}


