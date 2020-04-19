// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userTrack = try? newJSONDecoder().decode(UserTrack.self, from: jsonData)

import Foundation

// MARK: - TrackModel
struct TrackModel: Codable {
    var id: Int?
    var title: String?
    var duration: Int?
    var trackPosition: Int?
    var rank:Int?
    var releaseDate: String?
    var preview: String?
    var contributors: [Contributor]?
    var artist: Artist?
    var album: Album?

    enum CodingKeys: String, CodingKey {
        case id,  title
        case  duration
        case trackPosition = "track_position"
        case rank
        case releaseDate = "release_date"
        case preview
        case contributors, artist, album
    }
}

// MARK: - Contributor
struct Contributor: Codable {
    var id: Int?
    var name: String?
    var link, share, picture: String?
    var pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    var radio: Bool?
    var tracklist: String?
    var type, role: String?

    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type, role
    }
}
