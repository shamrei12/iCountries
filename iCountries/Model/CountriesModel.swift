//
//  CountriesModel.swift
//  iCountries
//
//  Created by Алексей Шамрей on 5.11.22.
//

import Foundation


struct CountriesModel {
    var startIndex: Int = 0
    var endIndex: Int = 19
    var endList = false
    var countCountries = 29
    var isLoadingCollection = false
    var serchingCollection = false
    var filterCollection: [CountriesProtocol] = []
    
    
    func allcountry() {
        
    }
}
