
import UIKit
import Kingfisher
import AVFoundation
class PlayerDetailView: UIViewController {
    var track:SearchDatum?{
        didSet{
            setupViews()
        }
    }
    var isEnabeld = false
    var repeatState = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupViews()
        observedTrackCurrentTime()
        
    }
    
    @objc func handleTapMaximize(){
        print(44444)
        let mainTabBar = keyWindow?.rootViewController as? MainTabBar
        
        mainTabBar?.maximizeDetailView(track: nil)
    }
    
    @objc func handlePan(gesture:UIPanGestureRecognizer){
        
        if gesture.state == .changed{
            handleChangeState(gesture: gesture)
            
        } else if gesture.state == .ended{
            
            handleEndState(gesture: gesture)
            
        }
    }
    
    func handleChangeState(gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.view.superview)
        if (translation.y<=71){
        self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
        print(translation.y)
        self.miniplayerView.alpha = 1 + translation.y / 250
        self.maximizeStackView.alpha = -translation.y / 250
        }
        else{
            dismiss(animated: true)
        }
       
    }
    
    func handleEndState(gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.view.superview)
        let speed  = gesture.velocity(in: self.view.superview)
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut,animations:  {
            
            self.view.transform = .identity
            
            
            
            if translation.y < -250  || speed.y < -500{
                
                let mainTabBar = self.keyWindow?.rootViewController as? MainTabBar
                
                mainTabBar?.maximizeDetailView(track: nil)
                gesture.isEnabled = false
                
            } else {
                self.miniplayerView.alpha = 1
                self.maximizeStackView.alpha = 0
            }
        })
    }
    
    
    var panGesture:UIPanGestureRecognizer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMaximize)))
        panGesture = (UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:))))
        self.view.addGestureRecognizer(panGesture)
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
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        miniPlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
       
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            self.player.pause()
            self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            self.miniPlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        
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
    
    @IBAction func dismisPlayerDetailView(_ sender: Any) {
        
    

    }
    //mini player
    
    @IBOutlet weak var miniTrackImage: UIImageView!
    @IBOutlet weak var miniTrackTitle: UILabel!
    @IBOutlet weak var miniPlayPauseButton: UIButton!{
        didSet{
            miniPlayPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    @IBOutlet weak var miniGoForwardButton: UIButton! {
        didSet{
            miniGoForwardButton.addTarget(self, action: #selector(handleGoForward(_:)), for: .touchUpInside)
        }
    }
    
    
    
    //maxi player
    @IBOutlet weak var maximizeStackView: UIStackView!
    @IBOutlet weak var miniplayerView: UIView!
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
            
            playPauseButton.addTarget(self, action: #selector(handlePlayPause) , for: .touchUpInside)
        }
    }
    @objc func handlePlayPause(){
        if player.timeControlStatus == .paused{
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            miniPlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            enlargeImageView()
            
        }else{
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            miniPlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            shrinkTrackImageView()
        }
        
    }
    
    
    
        @IBAction func repeatButtonTapped(_ sender: UIButton) {
            
            isEnabeld = !isEnabeld
            print(isEnabeld)
            
            if isEnabeld == true {
            
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
                           self.player.seek(to: CMTime.zero)
                           self.player.play()
                    self.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                    self.miniPlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                       }
                sender.tintColor = .systemPink
               
                          
            } else {
                sender.tintColor = .systemGray

                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
                    self.player.pause()
                    self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                    self.miniPlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                }
                
                return
            }
    }
    
    
    @IBAction func handleCurrentTimeSliderChange(_ sender: Any) {
        let percentage  = currentTimeSlider.value
        panGesture.isEnabled = false
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
        panGesture.isEnabled = false
        player.volume = sender.value
    }
    fileprivate func seekToCurrentTime (diff:Int64){
        let Seconds = CMTimeMakeWithSeconds(Float64(diff), preferredTimescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), Seconds)
        player.seek(to: seekTime)
    }
    
    
    let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    @IBAction func handleDismis(_ sender: Any) {
        // dismiss(animated: true, completion: nil)
        let mainTabBar = keyWindow?.rootViewController as? MainTabBar
        mainTabBar?.minimizeDetailView()
        panGesture.isEnabled = true
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
        
        self.trackTitle.text = track?.title ?? ""
        self.miniTrackTitle.text = track?.title ?? ""
        self.ArtistNameLabel.text = track?.artist?.name ?? ""
        self.DurationLAbel.text = "\(track?.duration ?? 30.0)"
        
        let urlString =  track?.album?.cover ?? ""
        if let url = URL(string: urlString){
            trackImageView.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.3))]
            trackImageView.kf.setImage(with: .network(url), options: options)
            miniTrackImage.kf.setImage(with: .network(url), options: options)
        }
        playSong()
    }
    
}
