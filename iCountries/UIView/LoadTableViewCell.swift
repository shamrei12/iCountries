//
//  LoadTableViewCell.swift
//  iCountries
//
//  Created by Алексей Шамрей on 26.10.22.
//

import UIKit

class LoadTableViewCell: UITableViewCell {

    @IBOutlet weak var animating: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
