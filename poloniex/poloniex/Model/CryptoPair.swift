//
//  CryptoPair.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/5/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

class CryptoPair {

    var name: String
    var id: Int
    var last: Float
    var lowestAsk: Float
    var highestBid: Float
    var percentChange: Float
    var baseVolume: Float
    var quoteVolume: Float
    var isFrozen: Bool
    var high24hr: Float
    var low24h: Float
    var old: CryptoPair?
    
    init(name: String,
                  id: Int,
                  last: Float,
                  lowestAsk: Float,
                  highestBid: Float,
                  percentChange: Float,
                  baseVolume: Float,
                  quoteVolume: Float,
                  isFrozen: Bool,
                  high24hr: Float,
                  low24hr: Float) {
        
        self.name = name
        self.id = id
        self.last = last
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.percentChange = percentChange
        self.baseVolume = baseVolume
        self.quoteVolume = quoteVolume
        self.isFrozen = isFrozen
        self.high24hr  = high24hr
        self.low24h = low24hr

    }
}
