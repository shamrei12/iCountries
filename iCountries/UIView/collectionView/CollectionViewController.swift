//
//  CollectionViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 30.10.22.
//

import UIKit
import Kingfisher
import SwiftUI
import CoreData

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == countries.endIndex && !countries.endList {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if !countries.isLoadingCollection {
            countries.isLoadingCollection = true
            DispatchQueue.global().async { [self] in
                if countries.endIndex + countries.countCountries <= self.allCountriesCollection.count - 1 {
                    countries.startIndex = countries.endIndex + 1
                    countries.endIndex += countries.countCountries
                } else {
                    countries.startIndex = countries.endIndex + 1
                    countries.endIndex = self.allCountriesCollection.count - 1
                    countries.endList = true
                }
                
                DispatchQueue.main.async { [self] in
                    if countries.endIndex ==  self.allCountriesCollection.count - 1  {
                        self.listCountries()
                        countries.isLoadingCollection = false
                        self.loadingView?.activityIndicator.stopAnimating()
                        self.loadingView?.activityIndicator.hidesWhenStopped = true
                        self.loadingView?.isHidden = true
                    } else {
                        self.listCountries()
                        countries.isLoadingCollection = false
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if countries.isLoadingCollection {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countryVC = CountryViewController.instantiate()
        countryVC.modalPresentationStyle = .fullScreen
        if countries.serchingCollection {
            countryVC.updateUIElements(country: filterCollection[indexPath.row].cca)
        } else {
            countryVC.updateUIElements(country: countriesCollection[indexPath.row].cca)
        }
        present(countryVC, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if countries.serchingCollection {
            return filterCollection.count
        } else {
            return countriesCollection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: CountriesCollectionViewCell
        if let reuseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountriesCollectionViewCell", for: indexPath) as? CountriesCollectionViewCell {
            cell = reuseCell
        } else {
            cell = CountriesCollectionViewCell()
        }
        return configure(cell: cell, for: indexPath)
    }
    
    private func configure(cell: CountriesCollectionViewCell, for indexPath: IndexPath) -> UICollectionViewCell {
        if countries.serchingCollection {
            DispatchQueue.global().async { [self] in
                let resurse = ImageResource(downloadURL: URL(string: filterCollection[indexPath.row].picture)!, cacheKey: filterCollection[indexPath.row].picture)
                DispatchQueue.main.async {
                    cell.iamgeCountry.kf.setImage(with: resurse)
                    cell.labelCountry.text = self.filterCollection[indexPath.row].name
                }
            }
            return cell
        } else {
            DispatchQueue.global().async { [self] in
                let url = URL(string: countriesCollection[indexPath.row].picture)!
                let resourseCell = ImageResource(downloadURL: url, cacheKey: countriesCollection[indexPath.row].picture)
                DispatchQueue.main.async {
                    cell.iamgeCountry.kf.setImage(with: resourseCell)
                }
            }
            cell.labelCountry.text = countriesCollection[indexPath.row].name
            return cell
        }
    }
}

extension CollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCollection.removeAll()
        guard searchText != "" || searchText != " " else {
            return
        }
        
        for item in allCountriesCollection {
            let text = searchText.lowercased()
            let isArrayContain = item.name.lowercased().range(of: text)
            if isArrayContain != nil {
                filterCollection.append(item)
            }
        }
        
        if searchBar.text == "" {
            countries.serchingCollection = false
            collectionView.reloadData()
        } else if searchBar.text == " " {
            countries.serchingCollection = false
            collectionView.reloadData()
        } else {
            countries.serchingCollection = true
            collectionView.reloadData()
        }
    }
}

class CollectionViewController: UIViewController {
    var listCountriesCoreData: [CountriesProtocol] = []
    private var name = [NSManagedObject]()
    @IBOutlet weak var searchBarCollection: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var loadingView: CollectionReusableView?
    private var allCountriesCollection: [CountriesProtocol] = []
    private var countriesCollection: [CountriesProtocol] = []
    private var filterCollection: [CountriesProtocol] = []
    private var countries: CountriesModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries = CountriesModel()
        allCountries()
        collectionView.register(UINib(nibName: "CountriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CountriesCollectionViewCell")
        let loadingReusableNib = UINib(nibName: "CollectionReusableView", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionReusableView")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false)
    }
    
    func allCountries() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest: NSFetchRequest<CountriesCoreData>
        fetchRequest = CountriesCoreData.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        let objects = try! context.fetch(fetchRequest)
        
        SessionManager.shared.countriesRequest { [self] welcomeElement in
            for country in 0...welcomeElement.count - 1 {
                allCountriesCollection.append(Countries(name: objects[country].name ?? "", picture: objects[country].picture ?? "", cca: objects[country].cca ?? ""))
            }
            self.listCountries()
        }
        
    }
    
    func listCountries() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest: NSFetchRequest<CountriesCoreData>
        fetchRequest = CountriesCoreData.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        let objects = try! context.fetch(fetchRequest)
        print(objects.count)
        for country in countries.startIndex...countries.endIndex {
            countriesCollection.append(Countries(name: objects[country].name ?? "", picture: objects[country].picture ?? "", cca: objects[country].cca ?? ""))
        }
        collectionView.reloadData()
    }
    
}


