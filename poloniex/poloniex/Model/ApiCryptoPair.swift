//
//  ApiCryptoPair.swift
//  poloniex
//
//  Created by Admin on 13/09/2019.
//  Copyright © 2019 merryweater. All rights reserved.
//

import Foundation

struct ApiCryptoPair {
    let id: Int
    let last: Float
    let lowestAsk: Float
    let highestBid: Float
    let percentChange: Float
    let baseVolume: Float
    let quoteVolume: Float
    let isFrozen: Bool
    let high24hr: Float
    let low24hr: Float
    
    enum CodingKeys: String, CodingKey {
        case id, last, lowestAsk, highestBid, percentChange, baseVolume, quoteVolume, isFrozen, high24hr, low24hr
    }
}

extension ApiCryptoPair: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        
        guard let lastFloat = Float(try values.decode(String.self, forKey: .last)) else {
            fatalError("The last is not a Float")
        }
        last = lastFloat
        
        
        guard let lowestAskFloat = Float(try values.decode(String.self, forKey: .lowestAsk)) else {
            fatalError("The lowestAsk is not a Float")
        }
        lowestAsk = lowestAskFloat
        
        
        guard let highestBidFloat = Float(try values.decode(String.self, forKey: .highestBid)) else {
            fatalError("The highestBid is not a Float")
        }
        highestBid = highestBidFloat
        
        
        guard let percentChangeFloat = Float(try values.decode(String.self, forKey: .percentChange)) else {
            fatalError("The percentChange is not a Float")
        }
        percentChange = percentChangeFloat
        
        guard let baseVolumeFloat = Float(try values.decode(String.self, forKey: .baseVolume)) else {
            fatalError("The baseVolume is not a Float")
        }
        baseVolume = baseVolumeFloat
        
        guard let high24hrFloat = Float(try values.decode(String.self, forKey: .high24hr)) else {
            fatalError("The high24hr is not a Float")
        }
        high24hr = high24hrFloat
        
        guard let quoteVolumeFloat = Float(try values.decode(String.self, forKey: .quoteVolume)) else {
            fatalError("The quoteVolume is not a Float")
        }
        quoteVolume = quoteVolumeFloat
        
        guard let low24hrFloat = Float(try values.decode(String.self, forKey: .low24hr)) else {
            fatalError("The baseVolume is not a Float")
        }
        low24hr = low24hrFloat
        
        guard let isFrozenBool = Int(try values.decode(String.self, forKey: .isFrozen)) else {
            fatalError("The isFrozen is not a Bool")
        }
        isFrozen = isFrozenBool != 0
    }
}
