
import UIKit
import Kingfisher

class SearchCell: UITableViewCell {
    
    //MARK:- IBOutlets and IBAActions
    @IBOutlet weak var trackImage:UIImageView!
    @IBOutlet weak var trackTitle:UILabel!
    @IBOutlet weak var trackDate:UILabel!
    @IBOutlet weak var ArtistName:UILabel!
    @IBOutlet weak var container:UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.trackImage.layer.cornerRadius = 15
        self.container.layer.cornerRadius = 5
        
    }
    
    
      var track:SearchDatum? {
          didSet {
            self.trackTitle.text = track?.title ?? ""
              self.trackTitle.textColor = .label
            self.ArtistName.text = track?.artist?.name ?? ""
              self.ArtistName.textColor = .secondaryLabel
//            self.trackDate.text = "\(track?.rank ?? 3.5)"
            
            let urlString =  track?.artist?.picture ?? ""
              if let url = URL(string: urlString){
                  trackImage.kf.indicatorType = .activity
                  let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.4))]
                  trackImage.kf.setImage(with: .network(url), options: options)
              }
          }
      }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
