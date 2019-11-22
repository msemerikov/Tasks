//
//  Task.swift
//  TaskList
//
//  Created by Mikhail Semerikov on 22.11.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import Foundation

class Task {
    
    var name: String
    var childs: [Task]
    
    internal init(name: String, childs: [Task]) {
        self.name = name
        self.childs = childs
    }
}
