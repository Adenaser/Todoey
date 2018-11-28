//
//  Category.swift
//  Todoey
//
//  Created by Abdelnaser L on 15.11.2018.
//  Copyright © 2018 Abdunnasır Lopez. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
