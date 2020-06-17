import Foundation
import Alamofire

class Api{
    
    static let shared = Api()
    private var decoder = JSONDecoder()
    
    
    
    
    
    func getTopCharts(genreId:Int,onSuccess:@escaping(SearchModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.Charts(genreId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    //print(response.result)
                    let chart =  try! self.decoder.decode(SearchModel.self, from: data)
                    onSuccess(chart,nil)
                    
                } catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    func getTopChartsArtist(genreId:Int,onSuccess:@escaping(ArtistModel?,Error?)->Void){
           decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request("https://api.deezer.com/chart/\(genreId)/artists?limit=20").responseJSON { (response) in
            
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    //print(response.result)
                    let search =  try! self.decoder.decode(ArtistModel.self, from: data)
                    onSuccess(search,nil)
                    
                }catch(let error) {
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
                    
                }catch(let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    func getUserTracks(userId:Int,onSuccess:@escaping(SearchModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.UserTracks(userId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let UsersTrack =  try! self.decoder.decode(SearchModel.self, from: data)
                    onSuccess(UsersTrack,nil)
                    
                }catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    func getArtistTopTracks(artistId:Int,onSuccess:@escaping(SearchModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request("https://api.deezer.com/artist/\(artistId)/top?limit=30").responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let UsersTrack =  try! self.decoder.decode(SearchModel.self, from: data)
                    onSuccess(UsersTrack,nil)
                    
                }catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    
    func getUser(userId:Int,onSuccess:@escaping(User?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.currentUser(userId)).responseJSON { (response) in
            if response.error == nil {
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let Users =  try? self.decoder.decode(User.self, from: data)
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
                    
                }catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
    
    
    
    
    
    func getArtistInfo(userId:Int,onSuccess:@escaping(ArtistModel?,Error?)->Void){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(DeezerEndPoints.UserArtist(userId)).responseJSON { (response) in
            if response.error == nil{
                do {
                    guard let data = response.data else {fatalError("data error")}
                    print(response.result)
                    let artists =  try! self.decoder.decode(ArtistModel.self, from: data)
                    onSuccess(artists,nil)
                    
                }catch (let error) {
                    print(error.localizedDescription)
                    onSuccess(nil,error)
                }
            }
        }
    }
    
}

