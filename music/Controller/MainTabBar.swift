
import UIKit
class MainTabBar:UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemPink
        UINavigationBar.appearance().prefersLargeTitles = true
        setupViewControllers()
    }
    
    
    
    //MARK:- setupViews
    func setupViewControllers(){
      
        viewControllers = [
                  generateNavigationController(for: SearchTracks(), title: "Search", image: #imageLiteral(resourceName: "music")),
                  generateNavigationController(for: SearchTracks(), title: "Artists", image: #imageLiteral(resourceName: "music")),
                  generateNavigationController(for: SearchTracks(), title: "Downloads", image: #imageLiteral(resourceName: "music"))
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
