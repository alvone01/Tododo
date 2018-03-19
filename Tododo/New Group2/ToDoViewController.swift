//
//  ViewController.swift
//  Tododo
//
//  Created by Alvin Harjanto on 3/6/18.
//  Copyright © 2018 Alvin Harjanto. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
//    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        
//        let newItem = Item()
//        newItem.title = "Biggo"
//        itemArray.append(newItem)
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let items = defaults.array(forKey: "ToDoItems") as? [Item] {
//            itemArray = items
//        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
        tableView.reloadData()
        
//        order of code matters ^
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//        ^^ to delete list (order matters)
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Tododododo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.parent = self.selectedCategory
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
//            self.defaults.setValue(self.itemArray, forKey: "ToDoItems")
            
            
        }
        
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "isi cups"
            textField = alertTextField
            
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItems() {
        
        do {
        try context.save()
            
        } catch {
            print("ERROR \(error)")
        }
        
        tableView.reloadData()
    }
    
//    func saveItemsE() {
//
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//
//        } catch {
//            print(error)
//        }
//    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        
        //to set default value to void parameter ^
    
//            let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parent.name MATCHES %@", selectedCategory!.name!)
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, categoryPredicate])
//
//        request.predicate = compoundPredicate
        
        
//        to check wether user calls another predicate when calling loadItems
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
            do {
                itemArray = try context.fetch(request)
            } catch {
                print(error)
            }
        
        tableView.reloadData()
    
        }
    
//    func loadItemsE() {
//
//            if let data = try? Data(contentsOf: dataFilePath!) {
//                let decoder = PropertyListDecoder()
//                do {
//                itemArray = try decoder.decode([Item].self, from: data)
//                } catch {
//                    print(error)
//                }
//            }
//
//    }
}

extension ToDoViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title contains[cd] %@", searchBar.text!)
        
        request.predicate = predicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with : request, predicate: predicate)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
        
        //to set the code inside into main thread, so that code can be executed even if other threads (ex. background threads are still running
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

