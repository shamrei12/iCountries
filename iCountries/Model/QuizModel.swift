//
//  QuizModel.swift
//  iCountries
//
//  Created by Алексей Шамрей on 24.09.22.
//

import Foundation

struct QuizGame {
    private var scoreTrue = 0
    private var scoreFalse = 0
    private var heart = 3
    private var countMistake = 0
    private var trueStrike = 0
    private var falseStrike = 0
    private var badCount = 0
    private var trueCount = 0
    var answer: String = ""
    var seconds: Int = 150
    var count: Int = 0
    
    func makeChoiceCountry(countryOne: String, countryTwo: String, countryThree: String, countryTrue: String) -> [String] {
        let reshuflCoutries = [countryOne, countryTwo, countryThree, countryTrue].shuffled()
        return reshuflCoutries
    }
    
    func radomiser(count: Int) -> Int {
        return Int.random(in: 0...count - 1)
    }
    
    mutating func clearMode() {
        scoreTrue = 0
        scoreFalse = 0
        countMistake = 0
        trueStrike = 0
        falseStrike = 0
        badCount = 0
        trueCount = 0
        heart = 3

    }
    
    func createNamePicture() -> String {
        return "\(self.heart)hearts.png"
    }
    
    mutating func checkAnswer(_ result: Bool) {
        if result {
            self.scoreTrue += 1
            self.trueStrike += 1
            self.falseStrike = 0
            self.trueCount += 1
            addTime()
            checkTrueStrike()
        } else {
            self.scoreFalse += 1
            self.falseStrike += 1
            self.trueStrike = 0
            self.trueCount = 0
            checkfalseStrike()
        }
    }
    
    mutating func checkTrueStrike() {
        if trueStrike == 2 {
            if heart < 3 {
                trueStrike = 0
                self.heart += 1

            }
            if badCount > 0 {
                badCount -= 1
            }
        }
    }
    mutating func checkfalseStrike() {
        if falseStrike == 2 {
            falseStrike = 0
            heart -= 1
            badCount += 1
        }
    }
    
    mutating func addTime() {
        if trueCount == 4 {
            seconds += 30
            trueCount = 0
        }
    }
    
    func checkEndGame() -> Bool {
        if badCount == 3 {
            return true
        } else {
            return false
        }
    }
    

    
    mutating func showTrueAnswer() {
        seconds -= 30
    }
    
    func makeUserResult() -> String {
        return "Вы набрали \(scoreTrue - scoreFalse) очков"
    }
    
    func showTrueScore() -> String {
        return "\(scoreTrue)"
    }
    
    func showFalseScore() -> String {
        return "\(scoreFalse)"
    }
    
}
