//
//  RecordTableViewCell.swift
//  Borrowed
//
//  Created by Mitali Chandna on 2015-11-15.
//  Copyright © 2015 Mitali Chandna. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lastRemindedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initalization Code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //Configure the view for the selected state 
    }
}
