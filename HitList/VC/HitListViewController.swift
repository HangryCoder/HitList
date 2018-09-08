//
//  ViewController.swift
//  HitList
//
//  Created by Sonia Wadji on 14/08/18.
//  Copyright © 2018 genora. All rights reserved.
//

import UIKit
import CoreData

class HitListViewController: UIViewController {
    
    private let personTableViewCell = "PersonTableViewCell"
    private let personTableViewCellId = "personTableViewCell"
    var people: [NSManagedObject] = []
    
    var persons: [PersonModel] = [PersonModel(name: "Sonia Wadji", age: 23, phoneNumber: "1234567890"),
                            PersonModel(name: "Krupa Bhat", age: 23, phoneNumber: "1234567890"),
                            PersonModel(name: "Stephen D'Souza", age: 26, phoneNumber: "1234567890"),
                            PersonModel(name: "Suhail Shaikh", age: 23, phoneNumber: "1234567890")]


    @IBOutlet weak var hitListTableView: UITableView!
    
    @IBAction func addPersonToHitList(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
        style: .default){
        [unowned self] action in
        
        guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else {
                return
            }
            
            guard let ageTextField = alert.textFields,
                let ageToSave = ageTextField[1].text else {
                    return
            }
            
            guard let phoneNumberTextField = alert.textFields?.last,
                let phoneNumberToSave = phoneNumberTextField.text else {
                    return
            }
        //self.names.append(nameToSave)
        let personModel = PersonModel(name: nameToSave, age: Int(ageToSave)!, phoneNumber: phoneNumberToSave)
        self.save(personModel: personModel)
        self.hitListTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Age"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Phone Number"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true)
    }
    
    func save(personModel: PersonModel) {

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
    
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(personModel.name, forKeyPath: "name")
        person.setValue(personModel.age, forKeyPath: "age")
        person.setValue(personModel.phoneNumber, forKeyPath: "phoneNumber")

        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hit List"
        
        hitListTableView.register(UINib.init(nibName: personTableViewCell, bundle: nil), forCellReuseIdentifier: personTableViewCellId)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")

        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension HitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: personTableViewCellId, for: indexPath) as! PersonTableViewCell
        
        let person = people[indexPath.row]
        let personModel: PersonModel = PersonModel(name: person.value(forKeyPath: "name") as! String,
                                                   age: person.value(forKeyPath: "age") as! Int,
                                      phoneNumber: person.value(forKeyPath: "phoneNumber") as! String)
        cell.setPerson(person: personModel)
        
        return cell
    }
}

