import UIKit
class ViewController : UIViewController {
    var myCollectionView:UICollectionView?
    
    var userTracksArrsy:[UserDatum]?
    var UserTrackInfo:TrackModel?
    var allGenere:[genereDatum]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectioView()
        fetchAllGenere()
        //fetchUserTracks(let:2882739824)
        
    }
    
    
    //MARK:- Setup Methods
//    fileprivate func fetchUserTracks(let usserId:Int){
//        Api.shared.getUserTracks(userId: usserId) { [weak self ](tracks, error) in
//            if error == nil{
//                self?.userTracksArrsy = tracks?.data
//                print(self?.userTracksArrsy?[1].artist)
//                self?.myCollectionView?.reloadData()
//            }
//        }
//    }
//    func fetchTrack(trackId:Int){
//        Api.shared.searchTrack(let: trackId) { [weak self ](track, error) in
//            guard let self = self else{return}
//            if error == nil{
//                self.UserTrackInfo = track
//                //print(self.UserTrackInfo?.SearchDatum?[1].preview)
//                print(self.UserTrackInfo)
//            }
//        }
//    }
//
    
    
    
    
    
    fileprivate func fetchAllGenere(){
        Api.shared.getGenre { [weak self](genere, error) in
            guard let self = self else{return}
            self.allGenere = genere?.data
            self.myCollectionView?.reloadData()
            
        }
    }
    
    
    
    fileprivate func setupCollectioView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        myCollectionView?.register(allGenereCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = .systemBackground
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
    }
}



//MARK:- CollectionView Methods

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGenere?.count ?? 0 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? allGenereCell
        let singleTrack = allGenere?[indexPath.item]
        myCell?.allGenere = singleTrack
        
        return myCell ?? UICollectionViewCell()
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genere = allGenere?[indexPath.item]
        let vc  = TopChartsVC.ArtistinitFromNib(generId: genere?.id ?? 0,image: genere?.picture ?? "")
        show(vc, sender: nil)
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItems:CGFloat = 4
        let padding:CGFloat = 16
        let width = view.frame.width
        let  totalWidth:CGFloat = ( width - numberOfItems * padding) / 2
        return CGSize(width: totalWidth, height: totalWidth + 46)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
