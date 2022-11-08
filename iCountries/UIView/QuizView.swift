//
//  QuizView.swift
//  iCountries
//
//  Created by Алексей Шамрей on 23.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox
import Kingfisher
import CoreData

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
        clearUI()
        quizGame.seconds = 150
    }
}

class QuizView: UIView, UIAlertViewDelegate {
    let cache = ImageCache.default
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
    private var quizGame: QuizGame!
    private var alertView: AlertView!
    var menu: BackMenu?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quizGame = QuizGame()
        downloadQuiz()
    }
    
    func setAlert() {
        stopwatch.invalidate()
        alertView = AlertView.loadFromNib()
        alertView.delegate = self
        addSubview(alertView)
        alertView.center = self.center
        makeText()
    }
    
    func downloadQuiz() {
        spinner.startAnimating()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest: NSFetchRequest<CountriesCoreData>
        fetchRequest = CountriesCoreData.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        let objects = try! context.fetch(fetchRequest)
        SessionManager.shared.countriesRequest { countries in
            let countryCount = countries.count
            let country = self.quizGame?.radomiser(count: countryCount) ?? 0
            let countryTrue = objects[country].name
            self.quizGame?.answer = countryTrue ?? ""

            DispatchQueue.global().async { [self] in
                let url = URL(string: countries[country].flags.png!)
                guard let url = url else { return }
                let resource = ImageResource(downloadURL: url, cacheKey: objects[country].picture)
                DispatchQueue.main.async { [self] in
                    self.countryFlags.kf.indicatorType = .activity
                    createTimer()
                    self.countryFlags.kf.setImage(with: resource)
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                    let countriesToQuiz = quizGame?.makeChoiceCountry(countryOne: objects[(quizGame?.radomiser(count: countryCount))!].name ?? "", countryTwo: objects[(quizGame?.radomiser(count: countryCount))!].name ?? "", countryThree: objects[(quizGame?.radomiser(count: countryCount))!].name ?? "", countryTrue: countryTrue ?? "")
                    makeScene()
                    makeChoice(countries: countriesToQuiz!)
                    countryFlags.layer.borderColor = UIColor.black.cgColor
                    countryFlags.layer.borderWidth = 1
                }
            }
        }
    }
    // MARK: - Timer
    func createTimer() {
        stopwatch = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func updateTimer() {
        quizGame.seconds -= 1
        if quizGame.seconds <= 0 {
            endGame()
        }
        timer.text = TimeManager.shared.convertToMinutes(seconds: quizGame.seconds)
    }
    
    func endGame() {
        if quizGame.checkEndGame() || quizGame.seconds <= 0 {
            setAlert()
            cancelScene()
        } else {
            downloadQuiz()
        }
    }
    // MARK: - Scene
    func makeScene() {
        quizGame.count = 0
        let massButton = [buttonOne, buttonTwo, buttonThree, buttonFour]
        for button in massButton {
            button?.layer.backgroundColor = UIColor.systemBlue.cgColor
            button?.isEnabled = true
            button?.isHidden = false
        }
    }
    
    func cancelScene() {
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
    }
    
    func clearUI() {
        trueScore.text = "0"
        falseScore.text = "0"
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
    // MARK: - LogicGame
    
    @IBAction func dropOne() {
        
        let massButton = [buttonOne, buttonTwo, buttonThree, buttonFour]
        for button in massButton {
            if button?.currentTitle != quizGame?.answer {
                quizGame.count += 1
                button?.isHidden = true
                if quizGame.count == 2 {
                    quizGame.seconds -= 5
                    break
                }
            }
        }
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        if sender.currentTitle == quizGame?.answer {
            quizGame.checkAnswer(true)
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
            quizGame.checkAnswer(false)
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
    // MARK: - HelpAnswer
    
    @IBAction func showNameCountry (_ sender: UIButton) {
        checkTrueAnswer()
        quizGame.showTrueAnswer()
    }
}
