//
//  QuizModel.swift
//  iCountries
//
//  Created by Алексей Шамрей on 24.09.22.
//

import Foundation

struct QuizGame {
    var scoreTrue: Int = 0
    var scoreFalse: Int = 0
    var answer: String = ""
    
    func makeChoiceCountry(countryOne: String, countryTwo: String, countryThree: String, countryTrue: String) -> [String] {
        let reshuflCoutries = [countryOne, countryTwo, countryThree, countryTrue].shuffled()
        return reshuflCoutries
    }
    mutating func trueAnswer() {
        scoreTrue += 1
    }
    mutating func falseAnswer() {
        scoreFalse += 1
    }
}
