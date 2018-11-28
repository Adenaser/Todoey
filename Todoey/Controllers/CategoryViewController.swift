//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdelnaser L on 9.11.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
    }
    let realm = try! Realm()
    var categories : Results<Category>?
    
    //Mark: - TableView Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1  //categories boş ise 1 olarak dön. Eğer boş değil ise categories'in toplamını dön.
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added"
        return cell
    }
    
    //Mark: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //Mark: - Data Manipulation Method
    
    func save( category: Category) {
        do{
            try realm.write {
                realm.add( category)
            }
        }catch{
            print("Error saving category \(error)")
        }
        tableView.reloadData()
        
    }
    func loadCategories(){
       categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    //Mark - Add New Categories
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        
    }
}

