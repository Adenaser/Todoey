//
//  ViewController.swift
//  Todoey
//
//  Created by Abdunnasır Lopez on 28.09.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArry = [String]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArry  = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        cell.textLabel?.text = itemArry[indexPath.row]
        
        return cell
        
        
    }
    
    
    //Mark - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //Satır seçildiğinde animasyonla seçime geçiyor.
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType  = .none
            }
            else{
                tableView.cellForRow(at: indexPath)?.accessoryType  = .checkmark
            }
        
        
    }


    //Mark - Add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoet item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != nil{
            self.itemArry.append(textField.text!)
            self.defaults.set(self.itemArry, forKey: "TodoListArray")
            self.tableView.reloadData()
                  }
        }
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create tavuk item"
            textField = alertTextField
        }
       alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    


}

