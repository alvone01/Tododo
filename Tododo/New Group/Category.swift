//
//  Category.swift
//  
//
//  Created by Alvin Harjanto on 3/20/18.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let list = List<Item>
}
