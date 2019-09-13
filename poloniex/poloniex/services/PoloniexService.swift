//
//  PoloniexService.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/5/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import Foundation
import UIKit
import RxAlamofire
import RxSwift

class PoloniexService {
    
    let tickerURL: String = "https://poloniex.com/public?command=returnTicker"

    
    func getTicker() -> Observable<[CryptoPair]> {
        return RxAlamofire.requestData(.get, tickerURL).map({ (response, data) -> [CryptoPair] in
            var cryptopairs = [CryptoPair]()
            let cryptopairsD = try JSONDecoder().decode(Dictionary<String, ApiCryptoPair>.self, from: data) 
                for (key, pair) in cryptopairsD {
                    cryptopairs.append(CryptoPair(name: key, data: pair))
                }
            
            return cryptopairs
        })
    }
}
