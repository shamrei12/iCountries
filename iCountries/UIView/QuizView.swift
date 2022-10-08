//
//  QuizView.swift
//  iCountries
//
//  Created by Алексей Шамрей on 23.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox

extension QuizView: AlertDelegate {
    
    func makeText() {
        alertView.userResult.text = quizGame.makeUserResult()
    }
    
    func leftAlertButton() {
        alertView.removeFromSuperview()
        menu?.backMenu()
    }
    
    func rightAlertButton() {
        alertView.removeFromSuperview()
        let image = UIImage(named: "\(quizGame.createNamePicture())")
        healthShow.image = image
        downloadQuiz()
        makeScene()
        quizGame.clearMode()
    }
}

class QuizView: UIView, UIAlertViewDelegate {
    private var alertView: AlertView!
    var menu: BackMenu?
    @IBOutlet weak private var countryFlags: UIImageView!
    @IBOutlet weak private var spinner: UIActivityIndicatorView!
    @IBOutlet weak private var buttonOne: UIButton!
    @IBOutlet weak private var buttonTwo: UIButton!
    @IBOutlet weak private var buttonThree: UIButton!
    @IBOutlet weak private var buttonFour: UIButton!
    @IBOutlet weak private var trueScore: UILabel!
    @IBOutlet weak private var falseScore: UILabel!
    @IBOutlet weak private var timer: UILabel!
    @IBOutlet weak private var showNameCountry: UIButton!
    @IBOutlet weak private var healthShow: UIImageView!
    private var stopwatch = Timer()
    private var seconds: Int = 150
    private var quizGame: QuizGame!
    private var count: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quizGame = QuizGame()
        downloadQuiz()
    }
    
    func setAlert() {
        alertView = AlertView.loadFromNib()
        alertView.delegate = self
        addSubview(alertView)
        alertView.center = self.center
        makeText()
    }
    
    func downloadQuiz() {
        
        spinner.startAnimating()
        SessionManager.shared.countriesRequest { countries in
            let countryCount = countries.count
            let country = self.quizGame?.radomiser(count: countryCount) ?? 0
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
                    let countriesToQuiz = quizGame?.makeChoiceCountry(countryOne: countries[(quizGame?.radomiser(count: countryCount))!].translations["rus"]?.common ?? "", countryTwo: countries[(quizGame?.radomiser(count: countryCount))!].translations["rus"]?.common ?? "", countryThree: countries[(quizGame?.radomiser(count: countryCount))!].translations["rus"]?.common ?? "", countryTrue: countryTrue)
                    makeScene()
                    makeChoice(countries: countriesToQuiz!)
                    countryFlags.layer.borderColor = UIColor.black.cgColor
                    countryFlags.layer.borderWidth = 1
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
        seconds -= 1
        if seconds == 0 {
            stopwatch.invalidate()
            endGame()
        }
        timer.text = TimeManager.shared.convertToMinutes(seconds: seconds)
    }
    
    func makeScene() {
        count = 0
        buttonOne.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonOne.isEnabled = true
        buttonOne.isHidden = false
        
        buttonTwo.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonTwo.isEnabled = true
        buttonTwo.isHidden = false
        
        buttonThree.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonThree.isEnabled = true
        buttonThree.isHidden = false
        
        buttonFour.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttonFour.isEnabled = true
        buttonFour.isHidden = false
    }
    
    func cancelScene() {
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
    }
    
    @IBAction func dropOne() {
        while count < 2 {
            if buttonOne.currentTitle != quizGame?.answer && buttonOne.isHidden != true {
                buttonOne.isHidden = true
                count += 1
            }
            else if buttonTwo.currentTitle != quizGame?.answer && buttonTwo.isHidden != true {
                buttonTwo.isHidden = true
                count += 1
            }
            else if buttonThree.currentTitle != quizGame?.answer && buttonThree.isHidden != true {
                buttonThree.isHidden = true
                count += 1
            }
            else if buttonFour.currentTitle != quizGame?.answer && buttonFour.isHidden != true {
                buttonFour.isHidden = true
                count += 1
            }
        }
        
        if count == 2 {
            seconds += 5
            count += 1
        }
    }
    
    func greenBackground(button: UIButton) {
        button.layer.backgroundColor = UIColor.systemGreen.cgColor
        button.titleLabel?.textColor = UIColor.black
    }
    
    func redBackground(button: UIButton) {
        button.layer.backgroundColor = UIColor.systemRed.cgColor
        button.titleLabel?.textColor = UIColor.black
    }
    
    func checkTrueAnswer() {
        if buttonOne.currentTitle == quizGame?.answer {
            buttonOne.layer.backgroundColor = UIColor.systemGreen.cgColor
            buttonOne.titleLabel?.textColor = UIColor.black
        }
        else if buttonTwo.currentTitle == quizGame?.answer {
            buttonTwo.layer.backgroundColor = UIColor.systemGreen.cgColor
            buttonTwo.titleLabel?.textColor = UIColor.black
        }
        else if buttonThree.currentTitle == quizGame?.answer {
            buttonThree.layer.backgroundColor = UIColor.systemGreen.cgColor
            buttonThree.titleLabel?.textColor = UIColor.black
        }
        else if buttonFour.currentTitle == quizGame?.answer {
            buttonFour.layer.backgroundColor = UIColor.systemGreen.cgColor
            buttonFour.titleLabel?.textColor = UIColor.black
        }
    }
    
    @IBAction func showNameCountry (_ sender: UIButton) {
        checkTrueAnswer()
        seconds += 10
    }
    
    func endGame() {
        if quizGame.checkEndGame() || seconds == 0 {
            setAlert()
        } else {
            downloadQuiz()
        }
    }
    
    func addTime() {
        if quizGame.addTime() {
            seconds += 60
        }
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        if sender.currentTitle == quizGame?.answer {
            addTime()
            quizGame?.trueAnswer()
            trueScore.text = "\(quizGame?.showTrueScore() ?? "0")"
            greenBackground(button: sender)
            cancelScene()
            AudioServicesPlaySystemSound(1000)
            stopwatch.invalidate()
            quizGame.checkTrueStrike()
            let image = UIImage(named: "\(quizGame.createNamePicture())")
            healthShow.image = image
            downloadQuiz()
        } else {
            quizGame?.falseAnswer()
            falseScore.text = "\(quizGame?.showFalseScore() ?? "0")"
            redBackground(button: sender)
            checkTrueAnswer()
            cancelScene()
            AudioServicesPlaySystemSound(1109)
            stopwatch.invalidate()
            quizGame.checkfalseStrike()
            let image = UIImage(named: "\(quizGame.createNamePicture())")
            healthShow.image = image
            if quizGame.checkEndGame() {
                endGame()
            } else {
                downloadQuiz()
            }
        }
    }
    
    func makeChoice(countries: [String]) {
        buttonOne.setTitle("\(countries[0])", for: .normal)
        buttonTwo.setTitle("\(countries[1])", for: .normal)
        buttonThree.setTitle("\(countries[2])", for: .normal)
        buttonFour.setTitle("\(countries[3])", for: .normal)
    }
}
