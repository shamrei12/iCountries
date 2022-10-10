//
//  CountryViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 16.09.22.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var picturesCountry: UIImageView!
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var languagesName: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var subregionName: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateUIElements(country: String) {
        SessionManager.shared.countryRequest(common: country, dataResponse: { [self] welcomeElement in
            
            DispatchQueue.global().async {
                let url = URL(string: welcomeElement[0].flags.png!)
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    
                    self.picturesCountry.image = image
                }
            }
            setupCountryInformation(country: welcomeElement.first)
        })
    }
    
    func setupCountryInformation(country: WelcomeElement?) {
        guard let country = country else { return }
        self.nameCountry.text = "Название страны: \(country.translations["rus"]?.official ?? "Неизвестно")"
        self.capitalName.text = "Столица: \(country.capital?[0] ?? "Неизвестно")"
        self.languagesName.text = "Языки: \(stringFormationLanguage(languages: country.languages))"
        self.population.text = "Население: \(countFormater(population: country.population))"
        self.subregionName.text = "Субрегион: \(country.subregion ?? "Неизвестно")"
        self.currencyName.text = "Валюта: \(stringFormatingCurrencies(currencies: country.currencies))"
    }
    
    func stringFormationLanguage(languages: [String: String]?) -> String {
        guard let languages = languages else { return "Неизвестно" }
        var stringLanguages: String = ""
        if languages.isEmpty {
            stringLanguages = "Неизвестно"
            return stringLanguages
        } else {
            for values in languages.values {
                stringLanguages += values
                stringLanguages += " "
            }
            return stringLanguages
        }
        
    }
    
    func countFormater(population: Int) -> String {
//        guard let population = population else { return "Неизвестно" }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        return "\(numberFormatter.string(for: population) ?? "Не установлено")"
    }
    func stringFormatingCurrencies(currencies: [String: [String:String]]?) -> String {
        guard let currencies = currencies else { return "Неизвестно"}
        var stringCurrencies: String = ""
        for value in currencies {
            stringCurrencies += "\(value.value["name"]!)(\(value.value["symbol"] ?? "Неизвестно")) "
        }
        return stringCurrencies
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
}

