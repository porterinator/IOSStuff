//
//  Recipe.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/8/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

struct Recipe: Decodable {
    let uuid: String
    let name: String
    let images: [String]
    let lastUpdated: Int
    let desc: String
    let instructions: String
    let difficulty: Int
}
