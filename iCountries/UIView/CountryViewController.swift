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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateUIElements(country: String) {
            SessionManager.shared.countryRequest(common: country, dataResponse: { [self] WelcomeElement in
                let url = URL(string: WelcomeElement[0].flags.png!)
                let data = try! Data(contentsOf: url!)
                print(data)
                let (name, capital, languages,
                     population, subregion) = stringFormation(nameCountry: WelcomeElement[0].translations["rus"]?.official ?? "", capitalName: WelcomeElement[0].capital?[0] ?? "", languages: WelcomeElement[0].languages ?? ["":""], population: WelcomeElement[0].population ?? 0, subregion: WelcomeElement[0].subregion ?? "")
                self.nameCountry.text = name
                self.capitalName.text = capital
                self.languagesName.text = languages
                self.population.text = population
                self.subregionName.text = subregion
                self.picturesCountry = UIImageView(image: UIImage(data: data, scale: 10.0))
            })
        }
    func stringFormation(nameCountry: String, capitalName: String, languages: [String: String],
                         population: Int, subregion: String) -> (String, String, String, String, String) {
        let name: String = "Название страны: \(nameCountry)"
        let capital: String = "Столица: \(capitalName)"
        let languages = "Языки: \(stringFormationLanguage(languages: languages))"
        let pop: String = "Население: \(population)"
        let subregion: String = "Субрегион \(subregion)"
        return (name, capital, languages, pop, subregion)
    }
    
    func stringFormationLanguage(languages: [String: String]) -> String {
        var stringLanguages: String = ""
        if languages.isEmpty {
            stringLanguages = "Неизвестно"
        } else {
            for values in languages.values {
                stringLanguages += values
                stringLanguages += " "
            }
        }
        return stringLanguages
    }

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
}
    
