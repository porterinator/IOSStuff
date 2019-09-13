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
    
    let tickerURL: String = "https://poloniex.com/public?command=returnTicker";

    
    func getTicker() -> Observable<[CryptoPair]> {
        return RxAlamofire.requestJSON(.get, tickerURL).map({ (response, json) -> [CryptoPair] in
            guard let resp = json as? [String: Any] else {
                return []
            }
            /*
             "id":7,"last":"0.00000050","lowestAsk":"0.00000050","highestBid":"0.00000049","percentChange":"-0.05660377","baseVolume":"49.92945219","quoteVolume":"96849508.55253161","isFrozen":"0","high24hr":"0.00000054","low24hr":"0.00000049"}
             */
            var cryptopairs = [CryptoPair]()
            for (key, value) in resp {
                let attributes = value as? [String : Any];
                let cryptoPair = CryptoPair(
                    name: key,
                    id: attributes!["id"] as! Int,
                    last: Float(attributes!["last"] as! String)!,
                    lowestAsk: Float(attributes!["lowestAsk"]  as! String)!,
                    highestBid: Float(attributes!["highestBid"]  as! String)!,
                    percentChange: Float(attributes!["percentChange"]  as! String)!,
                    baseVolume: Float(attributes!["baseVolume"]  as! String)!,
                    quoteVolume: Float(attributes!["quoteVolume"] as! String)!,
                    isFrozen: NSString(string: attributes!["isFrozen"] as! String).boolValue,
                    high24hr: Float(attributes!["high24hr"]  as! String)!,
                    low24hr: Float(attributes!["low24hr"]  as! String)!
                )
                cryptopairs.append(cryptoPair)
            }
            return cryptopairs
        })
    }
}
