//
//  AppDelegate.swift
//  iCountries
//
//  Created by Алексей Шамрей on 13.09.22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SessionManager.shared.countriesRequest { welcomeElement in
            for country in 0...welcomeElement.count - 1 {
                saveCountries(welcomeElement[country].translations["rus"]?.official ?? "", welcomeElement[country].flags.png!, welcomeElement[country].cca2)
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
                print("Saved! Good Job!")
            } catch {
                print(error.localizedDescription)
            }
        }

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "iCountries")
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         return container
     }()
    
    func saveContext () {
         let context = persistentContainer.viewContext
         if context.hasChanges {
             do {
                 try context.save()
             } catch {
                 let nserror = error as NSError
                 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
             }
         }
     }
}


