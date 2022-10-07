//
//  AlertView.swift
//  iCountries
//
//  Created by Алексей Шамрей on 2.10.22.
//

import UIKit


class AlertView: UIView {
    var delegate: AlertDelegate?
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var userResult: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func cancelGame(_ sender: UIButton) {
        delegate?.leftAlertButton()
        
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        delegate?.rightAlertButton()
        
    }
}
