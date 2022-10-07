//
//  QuizViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 23.09.22.
//

import UIKit

extension QuizViewController: BackMenu {
    func backMenu() {
        self.dismiss(animated: false)
    }
}
class QuizViewController: UIViewController {
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let quizView = self.view as? QuizView else { return }
        quizView.menu = self
    }
    
}
