import Alamofire
import Foundation


enum DeezerEndPoints:APIConfiguration{
    
    
    //MARK:- EndPoints
    case searchTrack(Int)
    case search(String)
    case ArtistInfo(Int)
    case AllGenere
    case currentUser(Int)
    case UserTracks(Int)
    case UserArtist(Int)
    case Charts(Int)
    
    
    
    
    
    static let baseUrlString = "https://api.deezer.com/"
    //MARK:- HTTPMethods
    var method: HTTPMethod{
        switch self {
        case .searchTrack,.AllGenere,.UserTracks,.currentUser:
            return .get
        case .search,.ArtistInfo,.UserArtist,.Charts:
            return .get
        }
    }
    
    //MARK:- Path
    var path: String{
        switch self {
        case .searchTrack(let trackId):
            return "track/\(trackId)"
        case .search(let name):
            return "search?q=\(name)"
        case .ArtistInfo(let artistId):
            return "artist/\(artistId)/top"
        case .AllGenere:
            return "genre"
        case .currentUser(let userId):
            return "user/\(userId)"
        case .UserTracks(let userID):
            return "user/\(userID)/tracks"
        case .UserArtist(let UserId):
            return "user/\(UserId)/artists"
        case .Charts(let genreId):
            return "chart/\(genreId)/tracks"
        }
    }
    
    //MARK:- Parameters
    var parameters: Parameters?{
        switch self {
        case .searchTrack,.search,.AllGenere,.ArtistInfo,.currentUser,.UserTracks,.UserArtist,.Charts:
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
        
        
        return  try encoding.encode(urlRequest, with: parameters)
    }
    
}


