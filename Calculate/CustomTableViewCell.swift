//
//  CustomTableViewCell.swift
//  Calculate
//
//  Created by Yudu Du on 5/19/17.
//  Copyright © 2017 Yudu Du. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var score: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var number: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
