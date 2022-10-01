//
//  QuizView.swift
//  iCountries
//
//  Created by Алексей Шамрей on 23.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox
class QuizView: UIView {
     
    @IBOutlet weak var countryFlags: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var trueScore: UILabel!
    @IBOutlet weak var falseScore: UILabel!
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
        buttonOne.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonOne.isEnabled = true


        buttonTwo.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonTwo.isEnabled = true
        
        buttonThree.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonThree.isEnabled = true
        

        buttonFour.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonFour.isEnabled = true
    }
    
    func cancelScene() {
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
        

    }
    
    func greenBackground(button: UIButton) {
        button.layer.backgroundColor = UIColor.systemGreen.cgColor
        button.titleLabel?.textColor = UIColor.white
    }
    
    func redBackground(button: UIButton) {
        button.layer.backgroundColor = UIColor.systemRed.cgColor
        button.titleLabel?.textColor = UIColor.white
    }

    func checkTrueAnswer() {
        if buttonOne.currentTitle == quizGame?.answer {
            buttonOne.layer.backgroundColor = UIColor.green.cgColor
        }
        else if buttonTwo.currentTitle == quizGame?.answer {
            buttonTwo.layer.backgroundColor = UIColor.green.cgColor
        }
        else if buttonThree.currentTitle == quizGame?.answer {
            buttonThree.layer.backgroundColor = UIColor.green.cgColor
        }
        else if buttonFour.currentTitle == quizGame?.answer {
            buttonFour.layer.backgroundColor = UIColor.green.cgColor
        }
    }
    @IBAction func clickedButton(_ sender: UIButton) {
        
        if sender.currentTitle == quizGame?.answer {
            quizGame?.trueAnswer()
            trueScore.text = "\(quizGame?.scoreTrue ?? 0)"
            greenBackground(button: sender)
            cancelScene()
            AudioServicesPlaySystemSound(1000)
            stopwatch.invalidate()
            
        } else {
            quizGame?.falseAnswer()
            falseScore.text = "\(quizGame?.scoreFalse ?? 0)"
            redBackground(button: sender)
            cancelScene()
            checkTrueAnswer()
            AudioServicesPlaySystemSound(1109)
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
