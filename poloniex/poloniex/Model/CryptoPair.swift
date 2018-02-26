//
//  CryptoPair.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/5/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

class CryptoPair: NSObject {

    public var name : String;
    public var id : Int;
    public var last : Float;
    public var lowestAsk : Float;
    public var highestBid : Float;
    public var percentChange : Float;
    public var baseVolume : Float;
    public var quoteVolume : Float;
    public var isFrozen : Bool;
    public var high24hr  : Float;
    public var low24hr : Float;
    public var old : CryptoPair?;
    
    init(name: String,
                  id: Int,
                  last: Float,
                  lowestAsk : Float,
                  highestBid : Float,
                  percentChange : Float,
                  baseVolume : Float,
                  quoteVolume : Float,
                  isFrozen : Bool,
                  high24hr  : Float,
                  low24hr : Float) {
        
        self.name = name;
        self.id = id;
        self.last = last;
        self.lowestAsk = lowestAsk;
        self.highestBid = highestBid;
        self.percentChange = percentChange;
        self.baseVolume = baseVolume;
        self.quoteVolume = quoteVolume;
        self.isFrozen = isFrozen;
        self.high24hr  = high24hr;
        self.low24hr = low24hr;
        super.init();
    }
}
