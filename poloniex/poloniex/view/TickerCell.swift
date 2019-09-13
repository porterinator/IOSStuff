//
//  TcikerCellTableViewCell.swift
//  poloniex
//
//  Created by Nikita Simonovich on 2/6/18.
//  Copyright © 2018 merryweater. All rights reserved.
//

import UIKit

class TickerCell: UITableViewCell {

    static let Identifier = "TickerCell"
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbVolume: UILabel!
    @IBOutlet weak var lbChange: UILabel!
    
    
    public func configureWithCryptoPair(cryptoPair: CryptoPair) {
        self.contentView.subviews[0].backgroundColor = UIColor(white: 1, alpha: 0)
        lbName.text = cryptoPair.name
        lbPrice.text = String(format: "%.8f", cryptoPair.data.last)
        lbVolume.text = String(format: "%.3f", cryptoPair.data.baseVolume)
        lbChange.text = String(format: "%.2f", cryptoPair.data.percentChange * 100)
        if cryptoPair.data.percentChange > 0 {
            lbChange.textColor = UIColor.green
            lbChange.text = "+" + lbChange.text!
        } else {
            lbChange.textColor = UIColor.red
        }
        if cryptoPair.old != nil {
            let old = cryptoPair.old!
            if (cryptoPair.data.last - old.data.last > 0) {
                UIView.animate(withDuration: 1, animations: {
                    self.contentView.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
                }, completion: { (complete) in
                    UIView.animate(withDuration: 1, animations: {
                        self.contentView.backgroundColor = UIColor.white
                    })
                })
            } else if cryptoPair.data.last - old.data.last < 0 {
                UIView.animate(withDuration: 1, animations: {
                    self.contentView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
                }, completion: { (complete) in
                    UIView.animate(withDuration: 1, animations: {
                        self.contentView.backgroundColor = UIColor.white
                    })
                })
            }
        }
    }

}
