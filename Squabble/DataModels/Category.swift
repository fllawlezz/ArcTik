//
//  Category.swift
//  Squabble
//
//  Created by Brandon In on 10/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

class Category: NSObject{
    var categoryName: String?;
    var categoryID: Int;
    
    init(categoryName: String, categoryID: Int){
        self.categoryName = categoryName;
        self.categoryID = categoryID;
    }
}
