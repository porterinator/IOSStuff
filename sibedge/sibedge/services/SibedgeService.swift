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
    
    let reciepesURL = "http://cdn.sibedge.com/temp/recipes.json";
    
    public func getRecipes() -> Observable<[Recipe]> {
        return RxAlamofire.requestJSON(.get, reciepesURL).map({ (response, json) -> [Recipe] in
            guard let resp = json as? [String : Any] else {
                return [];
            };
            var recipes = [Recipe]();
            for (value) in resp["recipes"] as! [Any] {
                let attributes = value as? [String : Any];
                /**
                 public var uuid : String;
                 public var name : String;
                 public var images : [String];
                 public var lastUpdated : Int;
                 public var desc : String;
                 public var instructions : String;
                 public var difficulty : Int;
                 */
                let recipe = Recipe(
                    uuid: attributes!["uuid"] as! String,
                    name: attributes!["name"] as! String,
                    images: attributes!["images"] as! [String],
                    lastUpdated: attributes!["lastUpdated"] as! Int,
                    description: attributes!["description"] as? String == nil ? "" : attributes!["description"] as! String,
                    instructions: attributes!["instructions"] as! String,
                    difficulty: attributes!["difficulty"] as! Int
                );
                recipes.append(recipe);
            }
            return recipes;
        });
    }

}
