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
    @IBOutlet weak var timer: UILabel!
    var stopwatch = Timer()
    var seconds: Int = 0
    
    
    var quizGame: QuizGame?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quizGame = QuizGame()
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
            self.quizGame?.answer = countryTrue
            DispatchQueue.global().async { [self] in
                let url = URL(string: countries[country].flags.png!)
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data, scale: 5.0)
                
                DispatchQueue.main.async { [self] in
                    self.countryFlags.image = image
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                    let countriesToQuiz = quizGame?.makeChoiceCountry(countryOne: countries[radomiser(count: countries.count)].translations["rus"]?.common ?? "", countryTwo: countries[radomiser(count: countries.count)].translations["rus"]?.common ?? "", countryThree: countries[radomiser(count: countries.count)].translations["rus"]?.common ?? "", countryTrue: countryTrue)
                    makeScene()
                    countryFlags.layer.borderWidth = 5
                    countryFlags.layer.borderColor = UIColor.black.cgColor
                    countryFlags.layer.cornerRadius = 20
                    makeChoice(countries: countriesToQuiz!)
                    createTimer()
                    
                }
            }
        }
        
    }
    
    func createTimer() {
         stopwatch = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(updateTimer),
                                          userInfo: nil,
                                          repeats: true)
     }
     
     @objc func updateTimer() {
         seconds += 1
         timer.text = TimeManager.shared.convertToMinutes(seconds: seconds)
         
     }
    
    func makeScene() {
        buttonOne.layer.borderWidth = 2
        buttonOne.layer.borderColor = UIColor.clear.cgColor
        buttonOne.isEnabled = true
        buttonTwo.layer.borderWidth = 2
        buttonTwo.layer.borderColor = UIColor.clear.cgColor
        buttonTwo.isEnabled = true
        buttonThree.layer.borderWidth = 2
        buttonThree.layer.borderColor = UIColor.clear.cgColor
        buttonThree.isEnabled = true
        buttonFour.layer.borderWidth = 2
        buttonFour.layer.borderColor = UIColor.clear.cgColor
        buttonFour.isEnabled = true
    }
    
    func cancelScene() {
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
        

    }
    
    func greenBorder(button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.green.cgColor
    }
    
    func redBorder(button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
    }

    func checkTrueAnswer() {
        if buttonOne.currentTitle == quizGame?.answer {
            buttonOne.layer.borderWidth = 2
            buttonOne.layer.borderColor = UIColor.green.cgColor
        }
        else if buttonTwo.currentTitle == quizGame?.answer {
            buttonTwo.layer.borderWidth = 2
            buttonTwo.layer.borderColor = UIColor.green.cgColor
        }
        else if buttonThree.currentTitle == quizGame?.answer {
            buttonThree.layer.borderWidth = 2
            buttonThree.layer.borderColor = UIColor.green.cgColor
        }
        else if buttonFour.currentTitle == quizGame?.answer {
            buttonFour.layer.borderWidth = 2
            buttonFour.layer.borderColor = UIColor.green.cgColor
        }
    }
    @IBAction func clickedButton(_ sender: UIButton) {
        
        if sender.currentTitle == quizGame?.answer {
            quizGame?.trueAnswer()
            score.text = "\(quizGame?.scoreGame ?? 0)"
            greenBorder(button: sender)
            cancelScene()
            stopwatch.invalidate()
            
        } else {
            quizGame?.falseAnswer()
            score.text = "\(quizGame?.scoreGame ?? 0)"
            redBorder(button: sender)
            cancelScene()
            checkTrueAnswer()
            stopwatch.invalidate()
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
