//
//  ViewController.swift
//  sibedge
//
//  Created by Nikita Simonovich on 3/8/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RecipesViewController: UIViewController {
    
    var recipesViewModel : RecipesViewModel?
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var sortingContol: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 116
        setupCellConfiguration()
        setupSearchFieldConfiguration()
        setupSortingControl()
        recipesViewModel?.getRecipes()
        self.title = "Recipes"
    }
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        recipesViewModel!.recipes.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: RecipeCellTableViewCell.Identifier, cellType: RecipeCellTableViewCell.self)) {
                    row, recipe, cell in
                    cell.configureWithRecipe(recipe: recipe)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func setupSearchFieldConfiguration() {
        searchTextField.rx.text
            .orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .bind(to: recipesViewModel!.filterString)
            .disposed(by: disposeBag)
    }
    
    private func setupSortingControl() {
        sortingContol.rx.selectedSegmentIndex.bind(to: recipesViewModel!.sortType).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "recipeDetailS") {
            let ds : RecipeDetailViewController = segue.destination as! RecipeDetailViewController
            guard
                let cell = sender as? RecipeCellTableViewCell,
                let row = tableView.indexPath(for: cell)?.row,
                let recipe = recipesViewModel?.recipes.value[row]
            else {
                    return
            }
            ds.recipeViewModel = RecipeViewModel(recipe: recipe)
        }
    }
    
}

