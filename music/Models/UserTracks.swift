
import Foundation

// MARK: - AlbumModel
struct UserTracks: Codable {
    var data: [UserDatum]?
    var total: Int?
}

// MARK: - Datum
struct UserDatum: Codable {
    var id: Int?
    var title: String?
    var duration:Float?
    var rank: Float?
    var album: Album?
    var artist: Artist?
}

