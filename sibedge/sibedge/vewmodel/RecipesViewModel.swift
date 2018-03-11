//
//  RecipesViewModel.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/9/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit
import RxSwift

class RecipesViewModel: NSObject {
    
    public let sortType : Variable<Int> = Variable(0);
    public let filterString : Variable<String> = Variable("");
    public let recipes : Variable<[Recipe]> = Variable([]);
    private var recipesService : SibedgeService? = nil;
    private let disposeBag = DisposeBag();
    private var originalRecipes : [Recipe] = [];
    
    init (sibedgeService : SibedgeService) {
        self.recipesService = sibedgeService;
    }
    
    public func getRecipes() {
        self.recipesService!.getRecipes().subscribe(onNext: { (recipes) in
            self.recipes.value = recipes;
            self.originalRecipes = recipes;
            self.sortRecipes();
        }).disposed(by: disposeBag);
        filterString.asObservable().subscribe(onNext: { (filter) in
            self.filterRecipes();
        }).disposed(by: disposeBag);
        sortType.asObservable().subscribe(onNext: { (type) in
            self.sortRecipes();
        }).disposed(by: disposeBag);
    }
    
    public func filterRecipes() {
        if (filterString.value.isEmpty) {
            self.recipes.value = originalRecipes;
        } else {
            let recipes = self.recipes.value;
            let filteredRecipes = recipes.filter { (recipe) -> Bool in
                return recipe.name.lowercased().contains(filterString.value)
                    || recipe.desc.lowercased().contains(filterString.value)
                    || recipe.instructions.lowercased().contains(filterString.value);
            }
            self.recipes.value = filteredRecipes;
        }
    }
    
    public func sortRecipes() {
        if (sortType.value == 0) {
            let sortedRecipes = self.originalRecipes.sorted(by: { (left, right) -> Bool in
                return right.name > left.name
            });
            self.recipes.value = sortedRecipes;
            originalRecipes = sortedRecipes;
        } else {
            let sortedRecipes = self.originalRecipes.sorted(by: { (left, right) -> Bool in
                return right.lastUpdated > left.lastUpdated
            });
            self.recipes.value = sortedRecipes;
            originalRecipes = sortedRecipes;
        }
    }

}
