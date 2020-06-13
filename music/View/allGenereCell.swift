import UIKit
import Kingfisher

class allGenereCell:UICollectionViewCell{
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "test"))
    let nameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stylizeUI()
        setupViews()
        
    }
    
    //MARK:- style UI
    fileprivate func stylizeUI() {
        nameLabel.text = "Podcast Name"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.minimumScaleFactor = 0.58
        nameLabel.textColor = .label
        nameLabel.adjustsFontSizeToFitWidth = true
       
    }
    
    fileprivate func setupViews() {
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        
        stackView.axis = .vertical
        // enables auto layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    
    //MARK:- configure cell
    var allGenere:genereDatum? {
        didSet {
            
            self.nameLabel.text = allGenere?.name
            self.imageView.layer.cornerRadius = 15
            guard let urlString = allGenere?.picture else { return  }
            if let url = URL(string: urlString){
                imageView.kf.indicatorType = .activity
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
                imageView.kf.setImage(with: .network(url), options: options)
                
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

