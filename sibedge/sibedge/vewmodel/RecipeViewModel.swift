//
//  RecipeViewModel.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/9/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

class RecipeViewModel: NSObject {
    
    public var recipe : Recipe;
    
    init(recipe : Recipe) {
        self.recipe = recipe;
    }

}
