//
//  Item.swift
//  Todoey
//
//  Created by Abdelnaser L on 15.11.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dataCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
