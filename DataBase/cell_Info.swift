//
//  cell_Info.swift
//  DataBase
//
//  Created by HeMu on 05/07/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit

class cell_Info: UITableViewCell {

    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var btnDel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
