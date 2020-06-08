
import UIKit
import Kingfisher
import AVFoundation
class PlayerDetailView: UIViewController {
    var track:SearchDatum?
    var repeatState = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        observedTrackCurrentTime()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let time = CMTimeMake(value: 1,timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            print("player start")
            self.enlargeImageView()
        }
    }
    
    
    static func initFromNib()->PlayerDetailView{
        let player = PlayerDetailView(nibName:XIBS.PlayerDetailView, bundle: nil)
        return player
    }
    
    //MARK:- AVPlayer Work
    var player:AVPlayer = {
        var avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    fileprivate func playSong(){
        guard let url  = URL(string: track?.preview ?? "") else { return}
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
    }
    
    
    
    fileprivate func observedTrackCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self](time) in
            
            self?.currentTimeLabel.text = time.toDisplayString()
            
            let durationTime = self?.player.currentItem?.duration
            self?.DurationLAbel.text = durationTime?.toDisplayString()
            self?.updateCurrentTimeSlider()
        }
    }
    
    fileprivate func updateCurrentTimeSlider(){
        
        // get the current time
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTime / duration
        self.currentTimeSlider.value = Float(percentage)
    }
    
    
    //MARK:- IBOutlet and IBActions
    
    @IBOutlet weak var trackImageView: UIImageView!
        {
        didSet{
            trackImageView.layer.cornerRadius = 5
            trackImageView.clipsToBounds = true
            trackImageView.transform = shrunkTransform
        }
    }
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var DurationLAbel: UILabel!
    @IBOutlet weak var ArtistNameLabel: UILabel!
    @IBOutlet weak var SoundSlider: UISlider!
    @IBOutlet weak var trackTitle: UILabel! {
        didSet {
            trackTitle.numberOfLines = 2
        }
    }
    @IBOutlet weak var playPauseButton:UIButton!{
        didSet{
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause) , for: .touchUpInside)
        }
    }
    @objc func handlePlayPause(){
        if player.timeControlStatus == .paused{
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            enlargeImageView()
            
        }else{
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            shrinkTrackImageView()
        }
        
    }
    
//
//
//    @IBAction func repeatButtonTapped(_ sender: UIButton) {
//            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
//                       self.player.seek(to: CMTime.zero)
//                       self.player.play()
//                   }
//            sender.tintColor = .systemPink
//            repeatState += 1
//            print(repeatState)
//
//    }
    
    
    @IBAction func handleCurrentTimeSliderChange(_ sender: Any) {
        let percentage  = currentTimeSlider.value
        
        guard let duration = player.currentItem?.duration else {return}
        
        let durationInSec = CMTimeGetSeconds(duration)
        
        let seekTimeInSec = Float64(percentage) * durationInSec
       
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSec, preferredTimescale: Int32(NSEC_PER_SEC))
        
        player.seek(to: seekTime)
    }
    
    @IBAction func handleGoBackword(_ sender: Any) {
        seekToCurrentTime(diff: -10)

    }
    
    @IBAction func handleGoForward(_ sender: Any) {
       seekToCurrentTime(diff: 10)
    }
    
    @IBAction func handleVolumeChange(_ sender: UISlider) {
        player.volume = sender.value
    }
    fileprivate func seekToCurrentTime (diff:Int64){
        let Seconds = CMTimeMakeWithSeconds(Float64(diff), preferredTimescale: 1)
               let seekTime = CMTimeAdd(player.currentTime(), Seconds)
               player.seek(to: seekTime)
    }
    
    
    @IBAction func handleDismis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //MARK:- AnimationViews
    
    private let shrunkTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    fileprivate func shrinkTrackImageView(){
        
        UIView.animate(withDuration: 0.73, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = self.shrunkTransform
        })
    }
    
    
    fileprivate func enlargeImageView(){
        UIView.animate(withDuration: 0.73, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = .identity
        })
    }
    
    
    //MARK:- setupViews
    
    fileprivate func setupViews() {
        playSong()
        self.trackTitle.text = track?.title ?? ""
        self.ArtistNameLabel.text = track?.artist?.name ?? ""
        self.DurationLAbel.text = "\(track?.duration ?? 30.0)"
        
        let urlString =  track?.album?.cover ?? ""
        if let url = URL(string: urlString){
            trackImageView.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.3))]
            trackImageView.kf.setImage(with: .network(url), options: options)
        }
    }

}
