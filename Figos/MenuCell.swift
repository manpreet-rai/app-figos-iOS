//
//  MenuCell.swift
//  Figos
//
//  Created by Manu on 07/06/21.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var variation: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
