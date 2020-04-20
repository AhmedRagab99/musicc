import Foundation
import Alamofire

class Api{
    
    static let shared = Api()
    private var decoder = JSONDecoder()
    
    
    
    
    
    func getTopCharts(genreId:Int,onSuccess:@escaping(Charts?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.Charts(genreId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    //print(response.result)
                    let chart =  try! self.decoder.decode(Charts.self, from: data)
                    onSuccess(chart,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    func search(let searchTerm:String,onSuccess:@escaping (SearchModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.deezer.com/search/track?q=\(searchTerm)").responseJSON { (response) in
            
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    //print(response.result)
                    let search =  try! self.decoder.decode(SearchModel.self, from: data)
                    onSuccess(search,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    func getUserTracks(userId:Int,onSuccess:@escaping(UserTracks?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.UserTracks(userId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let UsersTrack =  try! self.decoder.decode(UserTracks.self, from: data)
                    onSuccess(UsersTrack,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    func getUser(userId:Int,onSuccess:@escaping(User?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.currentUser(userId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let Users =  try! self.decoder.decode(User.self, from: data)
                    onSuccess(Users,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    func getGenre(onSuccess:@escaping(GenreModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.AllGenere).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let genres =  try! self.decoder.decode(GenreModel.self, from: data)
                    onSuccess(genres,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    func getArtistInfo(let artistId:Int,onSuccess:@escaping(Artist?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.ArtistInfo(artistId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let artists =  try! self.decoder.decode(Artist.self, from: data)
                    onSuccess(artists,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    func searchTrack(let trackId:Int,onSuccess:@escaping(TrackModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.searchTrack(trackId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                //    print(response.result)
                    let Tracks =  try! self.decoder.decode(TrackModel.self, from: data)
                    onSuccess(Tracks,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
}



