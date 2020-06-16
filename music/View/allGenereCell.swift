import UIKit
import Kingfisher

class allGenereCell:UICollectionViewCell{
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stylizeUI()
        setupViews()
        
    }
    
    //MARK:- style UI
    fileprivate func stylizeUI() {
        nameLabel.tintColor = .secondaryLabel
        nameLabel.backgroundColor = .systemBackground
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
       
    }
    
    fileprivate func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        
        stackView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        nameLabel.textAlignment = .center
        stackView.axis = .vertical
        stackView.spacing = 4
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
            self.imageView.layer.cornerRadius = 10
            guard let urlString = allGenere?.picture else { return  }
            if let url = URL(string: urlString){
                imageView.kf.indicatorType = .activity
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
                imageView.kf.setImage(with: .network(url), options: options)
                
            }
        }
    }
    
    
    
    func setupCell(artist:Artist){
        
        self.nameLabel.text = artist.name ?? ""
        imageView.layer.cornerRadius = 15
        guard let urlString = artist.picture else { return  }
        if let url = URL(string: urlString){
            imageView.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            imageView.kf.setImage(with: .network(url), options: options)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

