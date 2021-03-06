//
//  ViewController.swift
//  Todoey
//
//  Created by Abdunnasır Lopez on 28.09.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var todoItems : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
         //   todoItems  = items
        //}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none

        }else {
            cell.textLabel?.text = "No Items Added"
        }
    
        return cell
        
        
    }
    
    
    //Mark - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //Satır seçildiğinde animasyonla seçime geçiyor.
        
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status, \(error)")
            }
        }
            tableView.reloadData()
        
    }

    //Mark - Add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoet item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != nil{
                
                if let currentCategory = self.selectedCategory{
                    do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dataCreated = Date()
                    currentCategory.items.append(newItem)
                    
                        self.realm.add(newItem)
                    }
                    }catch{
                        print("Error saving new items, \(error)")
                    }
                    
                }
              self.tableView.reloadData()
//
                
            }
        }
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create tavuk item"
            textField = alertTextField
        }
       alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    
   

    //internal ve external parametre var bu func ta = den sonrası default değer oluyor.
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dataCreated", ascending: true)
        tableView.reloadData()
    }
}
    extension TodoListViewController: UISearchBarDelegate{

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dataCreated", ascending: true)
            
            tableView.reloadData()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
        
   }

