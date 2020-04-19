import Foundation

// MARK: - Album
struct Album: Codable {
    var id:Int?
    var title: String?
    var link, cover: String?
    var coverSmall, coverMedium, coverBig, coverXl: String?
    var releaseDate: String?
    var tracklist: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"
        case tracklist, type
    }
}

