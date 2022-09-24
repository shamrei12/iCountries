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
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var score: UILabel!
    var scoreGame: Int = 0
    var trueАnswer: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        downloadQuiz()
    }
    
    func radomiser(count: Int) -> Int {
        return Int.random(in: 0...count - 1)
    }
    func downloadQuiz() {
        spinner.startAnimating()
        SessionManager.shared.countriesRequest { countries in
            let country = self.radomiser(count: countries.count)
            let countryTrue = countries[country].translations["rus"]?.common ?? ""
            self.trueАnswer = countryTrue
            DispatchQueue.global().async { [self] in
                let url = URL(string: countries[country].flags.png!)
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data, scale: 5.0)
                
                DispatchQueue.main.async { [self] in
                    self.countryFlags.image = image
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                    self.makeChoiceCountry(countryOne: countries[radomiser(count: countries.count)].translations["rus"]?.common ?? "", countryTwo: countries[radomiser(count: countries.count)].translations["rus"]?.common ?? "", countryThree: countries[radomiser(count: countries.count)].translations["rus"]?.common ?? "", countryTrue: countryTrue)
                }
            }
        }
        
    }
    func makeChoiceCountry(countryOne: String, countryTwo: String, countryThree: String, countryTrue: String) {
        let reshuflCoutries = [countryOne,countryTwo, countryThree, countryTrue].shuffled()
        makeChoice(countries: reshuflCoutries)
    }

    @IBAction func clickedButton(_ sender: UIButton) {
        if sender.currentTitle == trueАnswer {
            scoreGame += 1
            score.text = "\(scoreGame)"
            
        } else {
            scoreGame -= 1
            score.text = "\(scoreGame)"
        }
        downloadQuiz()
    }
    
    func makeChoice(countries: [String]) {
        buttonOne.setTitle("\(countries[0])", for: .normal)
        buttonTwo.setTitle("\(countries[1])", for: .normal)
        buttonThree.setTitle("\(countries[2])", for: .normal)
        buttonFour.setTitle("\(countries[3])", for: .normal)
    }
    
    
}
