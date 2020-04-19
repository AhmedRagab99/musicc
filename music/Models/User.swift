import Foundation

// MARK: - User
struct User: Codable {
    var id:Int?
    var name: String?
    var link, picture: String?
    var pictureSmall, pictureMedium: String?
    var country: String?
    var tracklist: String?

    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
     
        case country, tracklist
    }
}
