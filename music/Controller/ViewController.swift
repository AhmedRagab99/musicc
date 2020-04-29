import UIKit
class ViewController : UIViewController {
    var myCollectionView:UICollectionView?
    
    var userTracksArrsy:[UserDatum]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectioView()
        fetchUserTracks(let:2882739824)
        
    }
    
    
    //MARK:- Setup Methods
    fileprivate func fetchUserTracks(let usserId:Int){
        Api.shared.getUserTracks(userId: usserId) { [weak self ](tracks, error) in
            if error == nil{
                self?.userTracksArrsy = tracks?.data
                self?.myCollectionView?.reloadData()
            }
        }
    }
    
    
    fileprivate func setupCollectioView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: self.view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        myCollectionView?.register(UserTracksCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = .systemBackground
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
    }
}



//MARK:- CollectionView Methods

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userTracksArrsy?.count ?? 0 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? UserTracksCell
        let singleTrack = userTracksArrsy?[indexPath.item]
        myCell?.UserTrack = singleTrack
        
        return myCell ?? UICollectionViewCell()
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
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
