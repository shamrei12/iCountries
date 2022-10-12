//
//  CountriesViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 13.09.22.
//

import UIKit

extension CountriesViewController: UITableViewDelegate {
    
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterCountries.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CountryTableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell {
            cell = reuseCell
        } else {
            cell = CountryTableViewCell()
        }
        
        return configure(cell: cell, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryVC = CountryViewController.instantiate()
        //        var name = countries[indexPath.row].common
        //        countryVC.country = name
        countryVC.modalPresentationStyle = .fullScreen
        if isSearching {
            countryVC.updateUIElements(country: filterCountries[indexPath.row].common)
        } else {
            countryVC.updateUIElements(country: countries[indexPath.row].common)
        }
        present(countryVC, animated: false)
    }
    
    private func configure(cell: CountryTableViewCell, for indexPath: IndexPath) -> CountryTableViewCell {
        if isSearching {
            DispatchQueue.global().async { [self] in
                let url = URL(string: filterCountries[indexPath.row].picture)
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data, scale: 5.0)
                DispatchQueue.main.async {
                    
                    cell.countryFlags.image = image
                }
            }
            cell.countryName.lineBreakMode = .byCharWrapping
            cell.countryName.numberOfLines = 2
            cell.countryName.text = filterCountries[indexPath.row].name
        } else {
            DispatchQueue.global().async { [self] in
                let url = URL(string: countries[indexPath.row].picture)
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data, scale: 5.0)
                DispatchQueue.main.async {
                    
                    cell.countryFlags.image = image
                }
            }
            cell.countryName.text = countries[indexPath.row].name
        }
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCountries.removeAll()
        guard searchText != "" || searchText != " " else {
            return
        }
        
        for item in countries {
            let text = searchText.lowercased()
            let isArrayContain = item.name.lowercased().range(of: text)
            if isArrayContain != nil {
                filterCountries.append(item)
            }
        }
        
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else if searchBar.text == " " {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            tableView.reloadData()
        }
        
    }
}

class CountriesViewController: UIViewController {
    
    
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var spinner: UIActivityIndicatorView!
    @IBOutlet weak private var tableView: UITableView!
    
    
    private var countries: [CountriesProtocol] = [] {
        didSet {
            countries.sort{ $0.name < $1.name }
        }
    }
    
    private var filterCountries: [CountriesProtocol] = [] {
        didSet {
            countries.sort{ $0.name < $1.name }
        }
    }
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        showCountries()
        spinner.startAnimating()
    }
    
    
    @IBAction func tappedBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
    
    func showCountries() {
        SessionManager.shared.countriesRequest { [self] WelcomeElement in
            for country in 0...WelcomeElement.count - 1 {
                countries.append(Countries(languages: WelcomeElement[country].languages ?? ["":""], name: WelcomeElement[country].translations["rus"]?.common ?? "", population: WelcomeElement[country].population, capital: WelcomeElement[country].capital?[0] as? String ?? "", picture: WelcomeElement[country].flags.png!, common: WelcomeElement[country].name.common.lowercased()))
            }
            tableView.reloadData()
        }
    }
}
