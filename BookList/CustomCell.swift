//
//  CustomCell.swift
//  BookList
//
//  Created by Andrew Barber on 9/28/16.
//  Copyright © 2016 Invictus. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var title : UILabel!
    @IBOutlet var author : UILabel!
    @IBOutlet var imageURL : UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
