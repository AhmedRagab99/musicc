import Alamofire
import Foundation


enum DeezerEndPoints:APIConfiguration{
    
    
    //MARK:- EndPoints
    case searchTrack(Int)
    case search(String)
    case ArtistTopTracks(Int)
    case AllGenere
    case currentUser(Int)
    case UserTracks(Int)
    case UserArtist(Int)
    case Charts(Int)
    case chartsTopArtist(Int)
    
    
    
    
    
    static let baseUrlString = "https://api.deezer.com/"
    //MARK:- HTTPMethods
    var method: HTTPMethod{
        switch self {
        case .searchTrack,.AllGenere,.UserTracks,.currentUser:
            return .get
        case .search,.ArtistTopTracks,.UserArtist,.Charts,.chartsTopArtist:
            return .get
        }
    }
    
    //MARK:- Path
    var path: String{
        switch self {
        case .searchTrack(let trackId):
            return "track/\(trackId)"
        case .search(let name):
            return "search/track?q=\(name)"
        case .ArtistTopTracks(let artistId):
            return "artist/\(artistId)/top?limit=50"
        case .AllGenere:
            return "genre"
        case .currentUser(let userId):
            return "user/\(userId)"
        case .UserTracks(let userID):
            return "user/\(userID)/flow"
        case .UserArtist(let UserId):
            return "user/\(UserId)/artists"
        case .Charts(let genreId):
            return "chart/\(genreId)/tracks"
        case .chartsTopArtist(let genere):
            return "chart/\(genere)/artists?limit=40"
        }
    }
    
    //MARK:- Parameters
    var parameters: Parameters?{
        switch self {
        case .searchTrack,.search,.AllGenere,.ArtistTopTracks,.currentUser,.UserTracks,.UserArtist,.Charts,.chartsTopArtist:
            return nil
        default:
            return nil
        
        
        }
    }
    
    //MARK:- EncodingParameters
    var encoding: ParameterEncoding{
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    //MARK:- URLRequestConvertable
    func asURLRequest() throws -> URLRequest {
        let url = try! DeezerEndPoints.baseUrlString.asURL()
        
        
          let urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: HTTPMethod(rawValue: method.rawValue))
        
        print(urlRequest.url?.absoluteURL)
        
        
        return  try encoding.encode(urlRequest, with: parameters)
    }
    
}


