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
            
            let (name, capital, languages,
                 population, subregion, currencies) = stringFormation(nameCountry: welcomeElement[0].translations["rus"]?.official ?? "", capitalName: welcomeElement[0].capital?[0] ?? "", languages: welcomeElement[0].languages ?? ["":""], population: welcomeElement[0].population ?? 0, subregion: welcomeElement[0].subregion ?? "", currencies: welcomeElement[0].currencies!)

            self.nameCountry.text = name
            self.capitalName.text = capital
            self.languagesName.text = languages
            self.population.text = population
            self.subregionName.text = subregion
            self.currencyName.text = currencies
        })
    }
    
    func stringFormation(nameCountry: String, capitalName: String, languages: [String: String],
                         population: Int, subregion: String, currencies: [String: [String:String]]) -> (String, String, String, String, String, String) {
        let name: String = "Название страны: \(nameCountry)"
        let capital: String = "Столица: \(capitalName)"
        let languages = "Языки: \(stringFormationLanguage(languages: languages))"
        let pop: String = "Население: \(population)"
        let subregion: String = "Субрегион: \(subregion)"
        let currencies: String = "Валюта: \(stringFormatingCurrencies(currencies: currencies))"
        return (name, capital, languages, pop, subregion, currencies)
    }
    
    func stringFormationLanguage(languages: [String: String]) -> String {
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
    
    func stringFormatingCurrencies(currencies: [String: [String:String]]) -> String {
        var stringCurrencies: String = ""
        for value in currencies {
            stringCurrencies += "\(value.value["name"]!)(\(value.value["symbol"]!)) "
        }
        return stringCurrencies
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
}

