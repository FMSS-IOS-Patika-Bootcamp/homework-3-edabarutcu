//
//  PhotoModel.swift
//  Homework3
//
//  Created by detaysoft on 19.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id : Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
