//
//  CategoryViewController.swift
//  Tododo
//
//  Created by Alvin Harjanto on 3/17/18.
//  Copyright © 2018 Alvin Harjanto. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var catArray : Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadItems()
    }


    
    //    MARK : - TV Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath)
        
        cell.textLabel?.text = catArray?[indexPath.row].name ?? "No Category Added"
        
        return cell
        
    }
    
    @IBAction func AddCatButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add NOW !", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
//            self.catArray.append(newCategory)
            
            self.saveCategory(category: newCategory)
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Enterooo!"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //    MARK : - Data Manipulation
    
    func saveCategory(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }
    
    
    func loadItems() {
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        catArray = realm.objects(Category.self)
        
//        do {
//
//            catArray = try context.fetch(request)
//        } catch {
//            print(error)
//        }
        
        tableView.reloadData()
    }
    
    
    

    
    //    MARK : - TV Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ItemSegue", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = catArray?[indexPath.row]
        }
        
        
    }
    

    
}
