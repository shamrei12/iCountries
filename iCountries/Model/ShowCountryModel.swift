//
//  Model.swift
//  iCountries
//
//  Created by Алексей Шамрей on 13.09.22.
//

import Foundation

protocol CountriesProtocol {
    var name: String { get set }
    var population: Int { get set }
    var capital: String { get set }
    var picture: String { get set}
    var common: String { get set }
    var cca: String {get set}
    var languages: [String: String]? { get set }
}

struct Countries: CountriesProtocol {
    var languages: [String: String]?
    var name: String
    var population: Int
    var capital: String
    var picture: String
    var common: String
    var cca: String
}



    
