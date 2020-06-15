
import Foundation



// MARK: - Artist

struct ArtistModel:Codable {
    let data:[Artist]?
}
struct Artist: Codable {
    var id:Int?
    var name: String?
    var  picture: String?
    var pictureSmall, pictureMedium: String?
    var tracklist: String?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case  tracklist
    }
}

