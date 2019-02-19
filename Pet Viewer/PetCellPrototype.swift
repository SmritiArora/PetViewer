//
//  PetCellPrototype.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 13/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import UIKit


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func prepareCell(name: String,descrip: String,img: String) {
        PetName.text = name
        
        if let imageUrl = URL(string: img) {
            PetImage.kf.setImage(with: imageUrl)
        }
        else
        {
            // TODO: show dummy image
        }
    }
    
    
}
