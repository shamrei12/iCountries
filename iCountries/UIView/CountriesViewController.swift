//
//  CountriesViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 13.09.22.
//

import UIKit

extension CountriesViewController: UITableViewDelegate {}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryVC = CountryViewController.instantiate()
//        var name = countries[indexPath.row].common
//        countryVC.country = name
        countryVC.modalPresentationStyle = .fullScreen
        countryVC.updateUIElements(country: countries[indexPath.row].common)
        present(countryVC, animated: false)
    }

    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        let url = URL(string: countries[indexPath.row].picture)
        let data = try! Data(contentsOf: url!)
        configuration.text = countries[indexPath.row].name
        configuration.secondaryText = "Столица: \(countries[indexPath.row].capital)"
        configuration.image = UIImage(data: data, scale: 5.0)

        cell.contentConfiguration = configuration
    }
}

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var countries: [CountriesProtocol] = [] {
        didSet {
            countries.sort{ $0.name < $1.name }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showCountries()
        
    }
    
    func showCountries() {
        SessionManager.shared.countriesRequest { [self] WelcomeElement in
            for country in 0...WelcomeElement.count - 1 {
                countries.append(Countries(languages: WelcomeElement[country].languages ?? ["":""], name: WelcomeElement[country].translations["rus"]?.official ?? "", population: WelcomeElement[country].population, capital: WelcomeElement[country].capital?[0] as? String ?? "", picture: WelcomeElement[country].flags.png!, common: WelcomeElement[country].name.common.lowercased()))
            }
            tableView.reloadData()
        }
    }
}
