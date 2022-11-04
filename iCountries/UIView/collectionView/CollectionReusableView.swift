//
//  UICollectionReusableView.swift
//  iCountries
//
//  Created by Алексей Шамрей on 30.10.22.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = UIColor.black
    }
    
}
