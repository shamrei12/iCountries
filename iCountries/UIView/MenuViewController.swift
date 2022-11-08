//
//  MenuViewController.swift
//  iCountries
//
//  Created by Алексей Шамрей on 22.09.22.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    private var storage = UserDefaults.standard
    private var storageKey = "checkValue"
    @IBOutlet var buttonCountries: UIButton!
    @IBOutlet var buttonQuiz: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
        buttonCountries.layer.cornerRadius = 10
        buttonQuiz.layer.cornerRadius = 10
    }

    @IBAction func tappedListCountry(_ sender: UIButton) {
        let countryVC = CollectionViewController.instantiate()
        //        var name = countries[indexPath.row].common
        //        countryVC.country = name
        countryVC.modalPresentationStyle = .fullScreen
        present(countryVC, animated: false)
    }
    
    @IBAction func tappedQuiz(_ sender: UIButton) {
        if storage.object(forKey: storageKey) != nil {
            let quizVC = QuizViewController.instantiate()
            quizVC.modalPresentationStyle = .fullScreen
            present(quizVC, animated: false)
        }
    }
    
    func data() {
        if storage.object(forKey: storageKey) == nil {
            print(1)
            storage.set(true, forKey: storageKey)
            if (storage.object(forKey: storageKey) != nil) == true {
                print(2)
                SessionManager.shared.countriesRequest { [self] welcomeElement in
                    for country in 0...welcomeElement.count - 1 {
                        saveCountries(welcomeElement[country].translations["rus"]?.official ?? "", welcomeElement[country].flags.png!, welcomeElement[country].cca2)
                    }
                }
            }
        }

    }

    func saveCountries(_ name: String,_ pictures: String, _ cca: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.newBackgroundContext()
//        do {
//            try context.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "CountriesCoreData")))
//            try context.save()
//        } catch let err {
//            print(err)
//        }
        let entity = NSEntityDescription.entity(forEntityName: "CountriesCoreData", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! CountriesCoreData
        taskObject.name = name
        taskObject.picture = pictures
        taskObject.cca = cca
        do {
            try context.save()
            print("SUKA")
        } catch {
            print(error.localizedDescription)
        }
        alletrtShow()
    }
    
    
    func alletrtShow() {
        let alertController = UIAlertController(title: "Данные о странах загружены", message: "Нажмите ОК чтобы продолжить", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
