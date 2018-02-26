//
//  TickerViewModel.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/5/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit
import RxSwift

class TickerViewModel: NSObject {
    
    public var cryptopairs : Variable<[CryptoPair]> = Variable([]);
    private let poloniexService : PoloniexService;
    let disposeBag = DisposeBag();
    
    init(poloniexService : PoloniexService) {
        self.poloniexService = poloniexService;
    }
    
    public func getCryptoPairs() {
        self.poloniexService.getTicker().subscribe(onNext: { (crypto) in
            print("Got ticker begin");
            let crypto = crypto.sorted(by: { (first, second) -> Bool in
                second.name > first.name
            })
            if (self.cryptopairs.value.count > 0) {
                for (index, pair) in crypto.enumerated() {
                    pair.old = self.cryptopairs.value[index];
                }
            }
            self.cryptopairs.value = crypto;
            print("Got ticker end");
        }).disposed(by: disposeBag);
    }

    public func startTicker() {
        getCryptoPairs();
        Observable<Int>.interval(3, scheduler: MainScheduler.instance).subscribe(onNext: { (i) in
            print("Timer begin");
            self.getCryptoPairs();
            print("Timer end");
        }).disposed(by: disposeBag);
    }
    
}
