//
//  MenuViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 22.09.22.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var buttonCountries: UIButton!
    @IBOutlet var buttonQuiz: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonCountries.layer.cornerRadius = 10
        buttonQuiz.layer.cornerRadius = 10
    }

    @IBAction func tappedListCountry(_ sender: UIButton) {
        let countryVC = CountriesViewController.instantiate()
        //        var name = countries[indexPath.row].common
        //        countryVC.country = name
        countryVC.modalPresentationStyle = .fullScreen
        present(countryVC, animated: false)
    }
    
    @IBAction func tappedQuiz(_ sender: UIButton) {
        let quizVC = QuizViewController.instantiate()
        quizVC.modalPresentationStyle = .fullScreen
        present(quizVC, animated: false)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
