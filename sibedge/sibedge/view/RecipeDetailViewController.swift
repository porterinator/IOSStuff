//
//  RecipeDetailViewController.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/9/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit
import ImageSlideshow

class RecipeDetailViewController: UIViewController {
    
    var recipeViewModel : RecipeViewModel?;
    
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var lbInstructions: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbName.text = recipeViewModel!.recipe.name;
        lbDesc.text = recipeViewModel!.recipe.desc;
        lbInstructions.text = recipeViewModel!.recipe.instructions;
        var inputSources = [InputSource]();
        for image in recipeViewModel!.recipe.images {
            inputSources.append(KingfisherSource(urlString: image)!);
        }
        imageSlideShow.contentScaleMode = .scaleAspectFill;
        imageSlideShow.setImageInputs(inputSources);
        self.title = self.recipeViewModel!.recipe.name;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
