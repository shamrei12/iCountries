//
//  TimeManager.swift
//  iCountries
//
//  Created by Алексей Шамрей on 24.09.22.
//

import Foundation


class TimeManager {
    
    static var shared: TimeManager = {
        let instance = TimeManager()
        return instance
    }()
    
    private init() {}
    
    func convertToMinutes(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .short
        
        let formattedString = formatter.string(from: TimeInterval(seconds))!
        return formattedString
    }
}
