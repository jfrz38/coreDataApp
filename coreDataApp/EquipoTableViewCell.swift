//
//  EquipoTableViewCell.swift
//  coreDataApp
//
//  Created by Aula11 on 4/12/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit

class EquipoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgEquipo: UIImageView!
    @IBOutlet weak var lblEquipo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
