//
//  DictionaryCell.swift
//  Dictionary(URLSession)
//
//  Created by Hasan Esat Tozlu on 21.09.2022.
//

import UIKit

class DictionaryCell: UITableViewCell {

    @IBOutlet weak var engLabel: UILabel!
    @IBOutlet weak var turLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
