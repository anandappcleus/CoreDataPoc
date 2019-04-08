//
//  UserDetailTVC.swift
//  CoreDataPoc
//
//  Created by Anand Pandey on 04/04/19.
//  Copyright © 2019 Anand Pandey. All rights reserved.


import UIKit
import CoreData

class UserDetailTVC: UITableViewController {

    var users = [User]()
    {
        didSet
        {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.getSavedUserData()
       
    }
    
    func getSavedUserData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //userFetch.fetchLimit = 1
        //userFetch.predicate = NSPredicate(format: "name = %@", "John")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: true)]
        
        do {
            let users = try managedContext.fetch(userFetch) as! [User]
            //let john: User = users.first as! User
           // print("Email: \(john.email!)")
            self.users = users as [User]
            //let johnCars = john.cars?.allObjects as! [Car]
            //print("has \(johnCars.count)")
        } catch let error as NSError {
            print("Could not retrieve. \(error), \(error.userInfo)")
        }        
        
    
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = self.users[indexPath.row].email

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // remove the deleted item from the model
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(self.users[indexPath.row])
            self.users.remove(at: indexPath.row)
            do {
                try managedContext.save()
            } catch _ {
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
