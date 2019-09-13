//
//  ViewController.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/5/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var tickerViewModel: TickerViewModel?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tickerTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tickerViewModel?.startTicker()
        self.tickerTable.rowHeight = 44
        setupCellConfiguration()
    }
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        tickerViewModel!.cryptopairs.asObservable()
            .bind(to: tickerTable
                .rx
                .items(cellIdentifier: TickerCell.Identifier, cellType: TickerCell.self)) {
                    row, cryptoPair, cell in
                    cell.configureWithCryptoPair(cryptoPair: cryptoPair);
            }
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

