
import Foundation

// MARK: - Charts
struct Charts: Codable {
    var data: [Datum]
    var total: Int
}

// MARK: - Datum
struct Datum: Codable {
    var id: Int
    var title: String
    var duration, rank: Int
    var preview: String
    var album: Album

    enum CodingKeys: String, CodingKey {
        case id, title
        case  duration, rank
        case preview , album
    }
}

// MARK: - Album
struct ChartsAlbum: Codable {
    var id: Int
    var title: String
    var cover: String
    var coverSmall, coverMedium, coverBig, coverXl: String?
    var tracklist: String
    var type: AlbumType

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case tracklist, type
    }
}

enum AlbumType: String, Codable {
    case album = "album"
}

// MARK: - Artist
struct ChartsArtist: Codable {
    var id: Int?
    var name: String?
    var  picture: String?
    var pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
    }
}


