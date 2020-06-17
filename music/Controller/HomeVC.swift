//
//  HomeVC.swift
//  music
//
//  Created by Ahmed Ragab on 6/15/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD


class HomeVC:UICollectionViewController{
    
    
    
    
    init(){
        let layout = HomeVC.createLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchAllGenre()
        fetchArtists(genere: 0)
        fetchArtists(genere: 132)
        fetchArtists(genere: 197)
        fetchArtists(genere: 12)
        fetchArtists(genere: 116)
        fetchArtists(genere: 2)
        
    }
    
    
    
    
    //MARK:- outlets and Variables
    
    
    var allGenere:[genereDatum]?
    var topArtist:[Artist]?
    var topArtist1:[Artist]?
    var topArtist2:[Artist]?
    var topArtist3:[Artist]?
    var topArtist4:[Artist]?
    var topArtist5:[Artist]?
    var topTracks:[SearchDatum]?
    
    
    
    //MARK:- Setup Functions
    
    
    
    
    fileprivate func fetchAllGenre(){
        Api.shared.getGenre { [weak self](genere, error) in
            guard let self = self else{return}
            if error == nil{
                self.allGenere = genere?.data
                self.collectionView.reloadData()
            }
        }
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
    
    
    fileprivate func fetchArtists(genere:Int){
        showIndicator(withTitle: "Loading", and: "load tracks and songs")
        Api.shared.getTopChartsArtist(genreId: genere) { [weak self] (artist, err) in
            guard let self = self else{return}
            if err == nil {
                if(genere==0){
                    self.topArtist = artist?.data
                    print(self.topArtist)
                    //self.collectionView.reloadData()
                    
                }
                else if (genere == 2){
                    self.topArtist5 = artist?.data
                }
                else if (genere == 116){
                    self.topArtist4 = artist?.data
                }
                else if(genere == 12){
                    self.topArtist3 = artist?.data
                    // self.collectionView.reloadData()
                }
                else if(genere==132){
                    self.topArtist1 = artist?.data
                    //   self.collectionView.reloadData()
                }
                else{
                    self.topArtist2 = artist?.data
                    print(self.topArtist2)
                    //self.collectionView.reloadData()
                    
                    
                }
                
                self.collectionView.reloadData()
                self.hideIndicator()
            }
        }
    }
    
    
    fileprivate func setupCollectionView(){
        
        collectionView.backgroundColor  = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(allGenereCell.self, forCellWithReuseIdentifier: "cell")
        
        //        collectionView.register(allGenereCell.self, forCellWithReuseIdentifier: HomeVC.cellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeVC.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    
    
    
    static func createLayout()->UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if(sectionNumber == 0){
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                item.contentInsets.leading = 16
                
                
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.37)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                section.contentInsets.bottom = 8
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                
                
                return section
            }
                
            else if  sectionNumber == 5 || sectionNumber == 1{
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
                item.contentInsets.trailing = 32
                item.contentInsets.bottom = 16
                
                
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 16
                
                
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                
                return section
                
                
            }
                
            else  if sectionNumber == 3 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(0.5)))
                
                item.contentInsets.bottom = 8
                item.contentInsets.trailing = 4
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(0.5)), subitems: [item,item])
                //                group.contentInsets.trailing = 16
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.bottom = 8
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                return section
                
            }
                
            else {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                
                
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 22
                
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.28)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 16
                section.contentInsets.leading = 16
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                return section
                
                
            }
            
        }
        
    }
    
    
    
    
    //MARK:- CollectionView Functions
    static let cellId = "cellId"
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? Header else{return UICollectionReusableView()}
        
        if indexPath.section == 5{
            header.labelText(text: "Top genre")
        }
        else if indexPath.section == 0{
            header.labelText(text: "")
            
        }
        else if indexPath.section == 1{
            header.labelText(text: "Popular Genre")
            
        }
        else if indexPath.section == 2{
            header.labelText(text: "Latin Artist")
        }
        else if indexPath.section == 3{
            header.labelText(text: "Popular Artist")
        }
        else if indexPath.section == 6{
            header.labelText(text: "Rap/Hip Hop")
        }
        else{
            
            header.labelText(text: "African Artist")
            
        }
        return header
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 || section == 5{
            
            print(topArtist1?.count)
            return allGenere?.distance(from: 0, to: 4 ) ?? 0
        }
        else if section == 2{
            return topArtist2?.count ?? 0
        }
        else if section == 3 {
            return topArtist?.count ?? 0
        }
        else if section == 0 {
            return topArtist3?.count ?? 0
        }
        else if section == 4{
            return topArtist5?.count ?? 0 - 10
        }
        else{
            return 20
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allGenereCell else {return UICollectionViewCell()}
        
        if indexPath.section == 2 {
            
            
            guard let artist1 = topArtist2?[indexPath.row ] else {return UICollectionViewCell()}
            cell.setupCell(artist: artist1)
            
            return cell
        }
        else if indexPath.section == 3{
            
            guard let artist1 = topArtist?[indexPath.row] else {return UICollectionViewCell()}
            cell.setupCell(artist: artist1)
            
            return cell
        }
            
        else if indexPath.section == 0{
            guard let artist1 = topArtist3?[indexPath.row] else {return UICollectionViewCell()}
            cell.setupCell(artist: artist1)
            return cell
        }
            
        else if  indexPath.section == 5{
            
            guard let genre = allGenere?[indexPath.row + 4] else {return UICollectionViewCell()}
            cell.setupCellWithgenere(genre: genre)
            
            
            
            return cell
        }
            
        else if indexPath.section == 1 {
            guard let genre = allGenere?[indexPath.row] else {return UICollectionViewCell()}
            cell.setupCellWithgenere(genre: genre)
            
            return cell
        }
            
        else if(indexPath.section == 4 ){
            
            
            guard let artist1 = topArtist5?[indexPath.row ] else {return UICollectionViewCell()}
            cell.setupCell(artist: artist1)
            
            return cell
        }
            
        else{
            guard let artist1 = topArtist4?[indexPath.row ] else {return UICollectionViewCell()}
            cell.setupCell(artist: artist1)
            
            return cell
        }
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            print(0)
        let artist = topArtist3?[indexPath.item]
            let vc  = ArtistTracksVC.ArtistTrackInitNib(artistId:artist?.id ?? 0, image: artist?.picture ?? "")
            show(vc, sender: nil)
            
        }
        else if indexPath.section == 1{
            print(2)
            let genere = allGenere?[indexPath.item]
                let vc  = ChartsTrack.ArtistinitFromNib(generId: genere?.id ?? 0,image: genere?.picture ?? "")
                show(vc, sender: nil)

        }
        else if indexPath.section == 2{
            print(3)
            let artist = topArtist2?[indexPath.item]
                      let vc  = ArtistTracksVC.ArtistTrackInitNib(artistId:artist?.id ?? 0, image: artist?.picture ?? "")
                      show(vc, sender: nil)
        }
        else if indexPath.section == 3{
            print(4)
            let artist = topArtist?[indexPath.item]
                               let vc  = ArtistTracksVC.ArtistTrackInitNib(artistId:artist?.id ?? 0, image: artist?.picture ?? "")
                               show(vc, sender: nil)
            
        }
        else if indexPath.section == 4{
            print(5)
            let artist = topArtist5?[indexPath.item]
                               let vc  = ArtistTracksVC.ArtistTrackInitNib(artistId:artist?.id ?? 0, image: artist?.picture ?? "")
                               show(vc, sender: nil)
        }
        else if indexPath.section == 5{
            print(6)
            let genere = allGenere?[indexPath.item+4]
                let vc  = ChartsTrack.ArtistinitFromNib(generId: genere?.id ?? 0,image: genere?.picture ?? "")
                show(vc, sender: nil)

        }
        else{
            print(7)
            let artist = topArtist4?[indexPath.item]
                               let vc  = ArtistTracksVC.ArtistTrackInitNib(artistId:artist?.id ?? 0, image: artist?.picture ?? "")
                               show(vc, sender: nil)
        }
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("not from here")
    }
    
}
