//
//  Recipe.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/8/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    public var uuid : String;
    public var name : String;
    public var images : [String];
    public var lastUpdated : Int;
    public var desc : String;
    public var instructions : String;
    public var difficulty : Int;
    
    init(
        uuid: String,
        name: String,
        images: [String],
        lastUpdated: Int,
        description: String,
        instructions: String,
        difficulty: Int
        ) {
        self.uuid = uuid;
        self.name = name;
        self.images = images;
        self.lastUpdated = lastUpdated;
        self.desc = description;
        self.instructions = instructions;
        self.difficulty = difficulty;
    }
}
