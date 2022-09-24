//
//  QuizView.swift
//  iCountries
//
//  Created by Алексей Шамрей on 23.09.22.
//

import UIKit

class QuizView: UIView {
    @IBOutlet weak var countryFlags: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        downloadQuiz()
        
    }
    
    func downloadQuiz() {
        spinner.startAnimating()
        SessionManager.shared.countriesRequest { contries in
            let country = Int.random(in: 0...contries.count - 1)
            DispatchQueue.global().async { [self] in
                let url = URL(string: contries[country].flags.png!)
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data, scale: 5.0)
                
                DispatchQueue.main.async {
                    self.countryFlags.image = image
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                }
            }
        }

    }
}
