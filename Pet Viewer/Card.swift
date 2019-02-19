//
//  Card.swift
//  Example
//
//  Created by HideakiTouhara on 2018/05/17.
//  Copyright © 2018年 HideakiTouhara. All rights reserved.
//

import UIKit
import Kingfisher

class Card: UIView {
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealTitle: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func prepareUI(text: String, img: String) {
        mealTitle.text = text
        
        if let imageUrl = URL(string: img) {
        mealImage.kf.setImage(with: imageUrl)
        }
        else
        {
            // TODO: show dummy image
        }
    }
}
