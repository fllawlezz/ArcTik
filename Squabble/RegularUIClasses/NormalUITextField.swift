//
//  NormalUITextField.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NormalUITextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 10, 0, 10));
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 10, 0, 10));
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 10, 0, 10));
    }
}
