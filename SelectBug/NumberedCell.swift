//
//  NumberedCell.swift
//  SelectBug
//
//  Created by Matheus Martins Susin on 2020-01-29.
//  Copyright © 2020 Matheus Martins Susin. All rights reserved.
//

import UIKit

class NumberedCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var originalPositionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
