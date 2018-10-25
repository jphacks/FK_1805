//
//  Photo.swift
//  WildCat
//
//  Created by Azuma on 2018/10/24.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    var imagePath: String

    enum CodingKeys: String, CodingKey {
        case imagePath = "image_url"
    }
}
