//
//  CountriesViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 13.09.22.
//

import UIKit
import Kingfisher

extension CountriesViewController: UITableViewDelegate {
    
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            if section == 0 {
                return filterCountries.count
            } else if section == 1 {
                return 0
            } else {
                return 0
            }
        } else {
            if section == 0 {
                return countries.count
            } else if section == 1 {
                return 1
            } else {
                // Return nothing
                return 0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        countryVC.modalPresentationStyle = .fullScreen
        if isSearching {
            countryVC.updateUIElements(country: filterCountries[indexPath.row].cca)
        } else {
            countryVC.updateUIElements(country: countries[indexPath.row].cca)
        }
        present(countryVC, animated: false)
    }
    
    private func configure(cell: CountryTableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            if isSearching {
                DispatchQueue.global().async { [self] in
                    let resurse = ImageResource(downloadURL: URL(string: filterCountries[indexPath.row].picture)!, cacheKey: filterCountries[indexPath.row].picture)
                    DispatchQueue.main.async {
                        cell.countryFlags.kf.setImage(with: resurse)
                        cell.countryName.text = self.filterCountries[indexPath.row].name
                    }
                    
                }
                return cell
            } else {
                DispatchQueue.global().async { [self] in
                    let url = URL(string: countries[indexPath.row].picture)!
                    let resourse = ImageResource(downloadURL: url, cacheKey: countries[indexPath.row].picture)
                    DispatchQueue.main.async {
                        cell.countryFlags.kf.setImage(with: resourse)
                    }
                }
                cell.countryName.text = countries[indexPath.row].name
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadTableViewCell", for: indexPath) as! LoadTableViewCell
            cell.animating.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pageNumberEnd, !isLoading {
            loadMoreData()
        }
        else if isSearching {
            self.isLoading = false
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                self.pageNumberStart = self.pageNumberEnd + 1
                self.pageNumberEnd += 20
                self.showCountries()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCountries.removeAll()
        self.setArray.removeAll()
        guard searchText != "" || searchText != " " else {
            return
        }
        
        for item in countries {
            let text = searchText.lowercased()
            let isArrayContain = item.name.lowercased().range(of: text)
            if isArrayContain != nil {
                filterCountries.append(item as! Countries)
                print(filterCountries)
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
    var setArray: Set<Countries> = []
    var pageNumberStart = 0
    var pageNumberEnd = 20
    var isLoading = false
    var isSearching = false
    let cache = ImageCache.default
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    
    
    private var countries: [CountriesProtocol] = []
    //    {
    ////        didSet {
    ////            countries.sort{ $0.name < $1.name }
    ////        }
    //    }
    
    private var filterCountries: [CountriesProtocol] = [] {
        didSet {
            countries.sort{ $0.name < $1.name }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cache.memoryStorage.config.totalCostLimit = 10 * 1024 * 1024
        cache.memoryStorage.config.countLimit = 10
        self.searchBar.delegate = self
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        tableView.register(UINib(nibName: "LoadTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadTableViewCell")
        showCountries()
    }
    
    
    @IBAction func tappedBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
    
    func showCountries() {
        SessionManager.shared.countriesRequest { [self] welcomeElement in
            for country in pageNumberStart...pageNumberEnd {
                countries.append(Countries(name: welcomeElement[country].translations["rus"]?.official ?? "", picture: welcomeElement[country].flags.png!, cca: welcomeElement[country].cca2))
            }
            tableView.reloadData()
        }
    }
}
