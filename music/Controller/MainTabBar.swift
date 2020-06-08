
import UIKit
class MainTabBar:UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemPink
        tabBar.barTintColor = .label
        UINavigationBar.appearance().prefersLargeTitles = true
        setupViewControllers()
        setupPlayerDetailVeiw()
    }
    
    
    
    
    
    
    
    
    let playerDetailView = PlayerDetailView.initFromNib()
    
    var maximizedTopAnchor:NSLayoutConstraint!
    var minimizedTopAnchor:NSLayoutConstraint!
    var bottomAnchor: NSLayoutConstraint!
    
    
    
     func maximizeDetailView(track:SearchDatum?){
        print(12312312)
        minimizedTopAnchor.isActive = false
        maximizedTopAnchor.isActive = true
        maximizedTopAnchor.constant = 0
        bottomAnchor.constant = 0
        
        
        
        if track != nil {
            playerDetailView.track = track
        }
//        print(playerDetailView.track)
//        print("////////////////////")
//        print(track)
        UIView.animate(withDuration: 0.5,delay: 0,usingSpringWithDamping: 0.7,initialSpringVelocity: 1,options: .curveEaseOut,animations:  {
            
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            self.playerDetailView.maximizeStackView.alpha = 1
            self.playerDetailView.miniplayerView.alpha = 0
        })
    }
    
    
    
    @objc func minimizeDetailView(){
        print(666666)
        maximizedTopAnchor.isActive = false
        //        maximizedTopAnchor.constant = 0
        bottomAnchor.constant = view.frame.height

        minimizedTopAnchor.isActive = true

        UIView.animate(withDuration: 0.5,delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1,options: .curveEaseOut,animations:  {
            
            self.tabBar.transform = .identity
            self.view.layoutIfNeeded()
            self.playerDetailView.maximizeStackView.alpha = 0
            self.playerDetailView.miniplayerView.alpha = 1

        })
    }
    
    fileprivate func setupPlayerDetailVeiw(){
        
        
        view.insertSubview(playerDetailView.view, belowSubview: tabBar)
        //auto layout
        playerDetailView.view.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchor = playerDetailView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchor.isActive = true
        
        
        bottomAnchor = playerDetailView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: view.frame.height)
            bottomAnchor.isActive = true

  
        
        minimizedTopAnchor = playerDetailView.view.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        playerDetailView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
    }
    
    
    
    //MARK:- setupViews
    func setupViewControllers(){
        
        viewControllers = [
            generateNavigationController(for: SearchTracks(), title: "Search", image: #imageLiteral(resourceName: "music")),
            generateNavigationController(for: SearchTracks(), title: "Artists", image: #imageLiteral(resourceName: "music")),
            generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "music"))
        ]
    }
    
    
    fileprivate func generateNavigationController (for rootViewController: UIViewController, title: String, image: UIImage)->UIViewController{
        
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
