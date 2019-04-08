//
//  ViewController.swift
//  CoreDataPoc
//
//  Created by Anand Pandey on 03/04/19.
//  Copyright © 2019 Anand Pandey. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


   
    func createUser()
    {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appdelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        for i in 0...5
        {
        user.setValue("anand\(i)", forKeyPath: "name")
        user.setValue("anand\(i)@test.com", forKey: "email")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "199\(i)/10/08")
        user.setValue(date, forKey: "date_of_birth")
        user.setValue(0, forKey: "number_of_children")
        }
        
        
        let carEntity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!
        let car1 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car1.setValue("Audi TT", forKey: "model")
        car1.setValue(2010, forKey: "year")
        car1.setValue(user, forKey: "user")
        
        let car2 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car2.setValue("BMW X6", forKey: "model")
        car2.setValue(2014, forKey: "year")
        car2.setValue(user, forKey: "user")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func go(completion:@escaping(_ msg:String,_ txt:String)->())
    {
        completion("","")
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        self.createUser()
    }
    
    @IBAction func viewButtonAction(_ sender: Any) {
        
        let userDetailTVC  = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailTVC") as? UserDetailTVC
        self.navigationController?.pushViewController(userDetailTVC!, animated: true)
    }
}

