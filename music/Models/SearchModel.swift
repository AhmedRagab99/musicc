
import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    var data: [SearchDatum]?
    var total: Int?
    var next: String?
}

// MARK: - Datum
struct SearchDatum: Codable {
    var id: Int?
    var title: String?
    var duration:Float?
    var rank: Float?
    var preview: String?
    var artist: Artist?
    var album: Album?

    enum CodingKeys: String, CodingKey {
        case id,title
        case  duration, rank
        case preview, artist, album
    }
}





enum Name: String, Codable {
    case eminem = "Eminem"
}



enum TitleVersion: String, Codable {
    case empty = ""
    case from8MileSoundtrack = "(From \"8 Mile\" Soundtrack)"
    case intro = "(Intro)"
    case musicFromTheMotionPicture = "(Music From The Motion Picture)"
}


