//
//  JugadorTableViewCell.swift
//  coreDataApp
//
//  Created by Aula11 on 4/12/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit

class JugadorTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var lblPlayer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
