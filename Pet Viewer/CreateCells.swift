//
//  CreateCells.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 13/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import Foundation


class PetList {
    
    var pet: [PetCellPrototype] = []
    
 init() {
        
        let row0Item = PetCellPrototype()
        
        row0Item.prepareCell(name: "Snuffy", descrip: "Dog", img: "http://images.dog.ceo/breeds/cockapoo/bubbles2.jpg")
        
        pet.append(row0Item)
        
    }
    
  /*  func newTodo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked  = true
        todos.append(item)
        return item
    }*/
    
}
