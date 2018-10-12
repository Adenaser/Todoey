//
//  ViewController.swift
//  Todoey
//
//  Created by Abdunnasır Lopez on 28.09.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArry = [Item]()
  
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArry.append(newItem)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArry  = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        let item = itemArry[indexPath.row]
       
        cell.textLabel?.text = item.title

        //Ternary operator
        cell.accessoryType = item.done == true ? .checkmark : .none
        //üst satır if else yaptığı işi yapıyor. : işaretine kadar if sonrası else bu sorguda true de silinebilir.
        //if item.done == true {
        //    cell.accessoryType = .checkmark
        //}
        //else{
        //    cell.accessoryType = .none
        //}
        return cell
        
        
    }
    
    
    //Mark - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //Satır seçildiğinde animasyonla seçime geçiyor.
        
        
        itemArry[indexPath.row].done = !itemArry[indexPath.row].done
        //Üst satır bu if else görevini yerine getiriyor
      //  if itemArry[indexPath.row].done == true {
      //      itemArry[indexPath.row].done = false
      //  }
      //  else{
      //      itemArry[indexPath.row].done = true
      //  }
        
     tableView.reloadData()
        
        
    }


    //Mark - Add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoet item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != nil{
                let newItem = Item()
                newItem.title = textField.text!
            self.itemArry.append(newItem)
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

