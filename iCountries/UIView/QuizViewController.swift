//
//  QuizViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 23.09.22.
//

import UIKit

class QuizViewController: UIViewController {

    @IBAction func tappedBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadQuiz()
    }
    
    func downloadQuiz() {
        
        SessionManager.shared.countriesRequest { contries in
            let country = Int.random(in: 0...contries.count - 1)
            
        }
    }
}
