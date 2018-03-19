//
//  CategoryViewController.swift
//  Tododo
//
//  Created by Alvin Harjanto on 3/17/18.
//  Copyright © 2018 Alvin Harjanto. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var catArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
        return catArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath)
        
        cell.textLabel?.text = catArray[indexPath.row].name
        
        return cell
        
    }
    
    @IBAction func AddCatButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add NOW !", style: .default) { (action) in
            
            let newItem = Category(context: self.context)
            newItem.name = textField.text
            self.catArray.append(newItem)
            
            self.saveItems()
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Enterooo!"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //    MARK : - Data Manipulation
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }
    
    
    func loadItems(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
//          save fetch to catArray if succeeds
            
            catArray = try context.fetch(request)
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    
    

    
    //    MARK : - TV Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ItemSegue", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = catArray[indexPath.row]
        }
        
        
    }
    

    
}
