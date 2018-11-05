//
//  ViewController.swift
//  Todoey
//
//  Created by Abdunnasır Lopez on 28.09.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArry = [Item]()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
       // if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
         //   itemArry  = items
        //}
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
        saveItems()
        //Üst satır bu if else görevini yerine getiriyor
      //  if itemArry[indexPath.row].done == true {
      //      itemArry[indexPath.row].done = false
      //  }
      //  else{
      //      itemArry[indexPath.row].done = true
      //  }
        
        
        
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
                self.saveItems()
                
            }
        }
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create tavuk item"
            textField = alertTextField
        }
       alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArry)
            try data.write(to:dataFilePath!)
        }
        catch {
            print("Error encoding item arry, \(error)")
        }
        self.tableView.reloadData()
        }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArry = try decoder.decode([Item].self, from: data)
        }
        catch {
            print("Error decoding item arry, \(errno)")
        }
    }
}


}
