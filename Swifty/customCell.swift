//
//  customCell.swift
//  Swifty
//
//  Created by Jeremy SCHOTTE on 1/22/18.
//  Copyright © 2018 Jeremy SCHOTTE. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pntLbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var lvlLbl: UILabel!
    @IBOutlet weak var progressLbl: UIProgressView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
