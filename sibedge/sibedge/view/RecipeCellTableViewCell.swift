//
//  RecipeCellTableViewCell.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/9/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeCellTableViewCell: UITableViewCell {
    
    static let Identifier = "RecipeCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var recipeImg: UIImageView!
    
    public func configureWithRecipe(recipe: Recipe) {
        self.name.text = recipe.name;
        self.desc.text = recipe.desc;
        self.recipeImg.kf.setImage(with: URL(string: recipe.images[0]));
        
    }
    
}
