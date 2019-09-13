//
//  SibedgeService.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/8/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import Foundation
import UIKit
import RxAlamofire
import RxSwift

class SibedgeService: NSObject {
    
    let reciepesURL = "http://cdn.sibedge.com/temp/recipes.json"
    
    func getRecipes() -> Observable<[Recipe]> {
        return RxAlamofire.requestData(.get, reciepesURL).map({ (response, data) -> [Recipe] in
            guard let recipes = try? JSONDecoder().decode([Recipe].self, from: data) else {
                return []
            }
            return recipes
        })
    }

}
