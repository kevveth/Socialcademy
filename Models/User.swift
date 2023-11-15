//
//  User.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/11/23.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
    var imageURL: URL?
}

extension User {
    static let testUser = User(
        id: "",
        name: "Kenneth Rathbun",
        imageURL: URL(string: "https://source.unsplash.com/lw9LrnpUmWw/480x480")
    )
}
