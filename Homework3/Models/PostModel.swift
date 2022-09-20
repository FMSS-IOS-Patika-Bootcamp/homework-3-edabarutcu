//
//  PostModel.swift
//  Homework3
//
//  Created by detaysoft on 19.09.2022.
//

import Foundation

struct Post: Decodable {
    var userID: Int
    var id: Int
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
