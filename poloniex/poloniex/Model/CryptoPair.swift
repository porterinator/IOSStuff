//
//  CryptoPair.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/5/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

class CryptoPair: Decodable {

    var name: String
    var data: ApiCryptoPair
    var old: CryptoPair?
    
    init(name: String,
         data: ApiCryptoPair) {
        
        self.name = name
        self.data = data

    }
}
