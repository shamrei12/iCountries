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
    @IBOutlet weak var dataDownload: UIButton!
    
    @IBOutlet weak var trueDownload: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trueDownload.layer.isHidden = true
        dataDownload.layer.isHidden = true
        checkDownload()
        buttonCountries.layer.cornerRadius = 10
        buttonQuiz.layer.cornerRadius = 10
    }
    
    func checkDownload() {
        if trueResult() {
            trueDownload.layer.isHidden = false
            dataDownload.layer.isHidden = true
        } else {
            trueDownload.layer.isHidden = true
            dataDownload.layer.isHidden = false
        }
    }
    
    @IBAction func tappedListCountry(_ sender: UIButton) {
        if trueResult() {
            let countryVC = CollectionViewController.instantiate()
            countryVC.modalPresentationStyle = .fullScreen
            present(countryVC, animated: false)
        } else {
                alletrtShow("Сначала загрузите данные о странах")
        }

    }
    
    @IBAction func tappedQuiz(_ sender: UIButton) {
        if trueResult() {
            let quizVC = QuizViewController.instantiate()
            quizVC.modalPresentationStyle = .fullScreen
            present(quizVC, animated: false)
        } else {
            alletrtShow("Сначала загрузите данные о странах")
        }
    }
    
    @IBAction func tappedDownload(_ sender: UIButton) {
        data()
    }
    
    func trueResult() -> Bool {
        if storage.object(forKey: storageKey) != nil {
            if (storage.object(forKey: storageKey) as? Bool)! {
                return true
            } else {
                return false
            }
        } else {
                return false
        }
    }
    
    func data() {
            storage.set(true, forKey: storageKey)
            SessionManager.shared.countriesRequest { [self] welcomeElement in
                for country in 0...welcomeElement.count - 1 {
                    saveCountries(welcomeElement[country].translations["rus"]?.official ?? "", welcomeElement[country].flags.png!, welcomeElement[country].cca2)
                }
            }
        }
    
    func getDate(_ times: [String]) -> String {
        var time: String = ""
        var set: Set<String> = []
        for i in times {
            set.insert(TimeManager.shared.curentDate(i))
        }
        for j in set {
            time += j
            if set.count > 1 {
                time += " "
            }
            
        }
        return time
    }
    
    func getTime(_ times: [String]) -> String {
        var time: String = ""
        for i in times {
            time += TimeManager.shared.solstice(i)
            time += " "
        }
        return time
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
        } catch {
            print(error.localizedDescription)
        }
        checkDownload()
    }
    
    
    func alletrtShow(_ text: String) {
        let alertController = UIAlertController(title: text, message: "Нажмите ОК чтобы продолжить", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
}
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

