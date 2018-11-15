//
//  NoHeadlinesCell.swift
//  Squabble
//
//  Created by Brandon In on 11/15/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class NoHeadlinesCell: UICollectionViewCell{
    
    var messageLabel: NormalUILabel = {
        let messageLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        messageLabel.text = "Sorry there are no posts in your area... Be the First!! :)";
        messageLabel.numberOfLines = 0;
        return messageLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.veryLightGray;
        setupMessageLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupMessageLabel(){
        self.addSubview(messageLabel);
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
}
