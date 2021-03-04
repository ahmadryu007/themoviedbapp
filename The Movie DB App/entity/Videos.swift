//
//  Videos.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation
// MARK: - Videos
struct Videos: Codable {
    let id: Int?
    let results: [Video]
}

// MARK: - Result
struct Video: Codable {
    let id, iso639_1, iso3166_1: String?
    let key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
