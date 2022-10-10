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
    var answer: String = ""
    private var heart = 3
    private var countMistake = 0
    private var trueStrike = 0
    private var falseStrike = 0
    private var badCount = 0
    private var trueCount = 0
    
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
    
    mutating func trueAnswer() {
        self.scoreTrue += 1
        self.trueStrike += 1
        self.falseStrike = 0
    }
    
    mutating func falseAnswer() {
        self.scoreFalse += 1
        self.falseStrike += 1
        self.trueStrike = 0
    }
    
    func createNamePicture() -> String {
        return "\(self.heart)hearts.png"
    }
    
    mutating func checkTrueStrike() {
        if trueStrike == 3 {
            if heart < 3 {
                heart += 1
            }
            trueCount += 1
            trueStrike = 0
            badCount -= 1
        }
    }
    mutating func addTime() -> Bool {
        if trueCount == 4 {
            self.trueCount = 0
            return true
        } else {
            return false
        }
    }
    
    func checkEndGame() -> Bool {
        if badCount == 3 {
            return true
        } else {
            return false
        }
    }
    
    mutating func checkfalseStrike() {
        if falseStrike == 2 {
            falseStrike = 0
            heart -= 1
            badCount += 1
        }
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
