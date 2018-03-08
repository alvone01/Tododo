//
//  ViewController.swift
//  Tododo
//
//  Created by Alvin Harjanto on 3/6/18.
//  Copyright © 2018 Alvin Harjanto. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Biggo"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Ciggo"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Diggo"
        itemArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "ToDoItems") as? [String]  {
//            itemArray = items
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Tododododo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "ToDoItems")
            
            self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "isi cups"
            textField = alertTextField
            
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

