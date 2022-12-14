//
//  Protocols.swift
//  iCountries
//
//  Created by Алексей Шамрей on 7.10.22.
//

import Foundation

protocol AlertDelegate {
    func leftAlertButton()
    func rightAlertButton()
    func makeText()
}

protocol BackMenu {
    func backMenu()
}
