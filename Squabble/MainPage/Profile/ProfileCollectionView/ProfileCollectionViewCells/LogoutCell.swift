//
//  LogoutCell.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class LogoutCell: UICollectionViewCell{
    
    lazy var logoutTitleLabel: NormalUILabel = {
        let logoutTitleLabel = NormalUILabel(textColor: .black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        logoutTitleLabel.text = "Logout";
        return logoutTitleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupLogoutTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupLogoutTitleLabel(){
        self.addSubview(logoutTitleLabel);
        logoutTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true;
        logoutTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        logoutTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        logoutTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
}
