//
//  QuizModel.swift
//  iCountries
//
//  Created by Алексей Шамрей on 24.09.22.
//

import Foundation

struct QuizGame {
    var scoreGame: Int = 0
    var answer: String = ""
    
    func makeChoiceCountry(countryOne: String, countryTwo: String, countryThree: String, countryTrue: String) -> [String]{
        let reshuflCoutries = [countryOne, countryTwo, countryThree, countryTrue].shuffled()
        return reshuflCoutries
    }
    mutating func trueAnswer() {
        scoreGame += 1
    }
    mutating func falseAnswer() {
        scoreGame -= 1
    }
}
