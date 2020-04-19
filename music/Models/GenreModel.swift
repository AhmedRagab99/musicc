import Foundation


// MARK: - UserTrack
struct GenreModel: Codable {
    var data: [genereDatum]
}

// MARK: - Datum
struct genereDatum: Codable {
    var id:Int?
    var name: String?
    var picture: String?
    var pictureSmall, pictureMedium: String?
    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
    }
}


