//
//  HomeVC.swift
//  music
//
//  Created by Ahmed Ragab on 6/15/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Kingfisher


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
    }
    
    
    
    
    //MARK:- outlets and Variables
    
    
    var allGenere:[genereDatum]?
    var topArtist:[Artist]?
    var topArtist1:[Artist]?
    var topArtist2:[Artist]?
    var topTracks:[SearchDatum]?


    
    //MARK:- Setup Functions
    
    
    
    
    fileprivate func fetchAllGenre(){
            Api.shared.getGenre { [weak self](genere, error) in
                guard let self = self else{return}
                    self.allGenere = genere?.data
                self.collectionView.reloadData()
            }
        }
    
    
   
    
    
    
    fileprivate func fetchArtists(genere:Int){
        Api.shared.getTopChartsArtist(genreId: genere) { [weak self] (artist, err) in
            guard let self = self else{return}
            if err == nil {
                if(genere==0){
                    self.topArtist = artist?.data
                    print(self.topArtist)
                    self.collectionView.reloadData()

                    
                }
                else if(genere==132){
                    self.topArtist1 = artist?.data
                    print(self.topArtist1)
                    self.collectionView.reloadData()

                   
                }
                else{
                    self.topArtist2 = artist?.data
                    print(self.topArtist2)
                    self.collectionView.reloadData()

                   
                }
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
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(1)))
//            item.contentInsets.trailing = 16
            item.contentInsets.bottom = 16
            
                
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(380)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets.top = 16
            section.contentInsets.bottom = 8

           
            return section
        }
                
            else if  sectionNumber == 5{
                
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
                section.contentInsets.bottom = 8
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

        if indexPath.section == 1{
        header.labelText(text: "Music")
        }
        else if indexPath.section == 2{
            header.labelText(text: "one")

        }
        else{
            header.labelText(text: "two")

        }
              return header
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 7
      }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 || section == 5{
         
            print(topArtist1?.count)
            return ((topArtist1?.distance(from: 0, to: 4) ?? 0 ) )
        }
        
        return topArtist1?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 1){
        
            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allGenereCell else {return UICollectionViewCell()}
        
            guard let artist1 = topArtist1?[indexPath.row] else {return UICollectionViewCell()}
        cell.setupCell(artist: artist1)
        
        return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            //cell.backgroundColor = .red
            return cell
        }
        
    }
  
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("not from here")
    }
    
}
