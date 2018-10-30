//
//  LocalOrGlobalView.swift
//  Squabble
//
//  Created by Brandon In on 8/8/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class LocalOrGlobalView: UIView{
    let localTitleLabel: NormalUILabel = {
        let localTitleLabel = NormalUILabel(textColor: .black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        localTitleLabel.text = "Local";
        return localTitleLabel;
    }()
    
    let selectorSwitch: UISwitch = {
        let selectorSwitch = UISwitch();
        selectorSwitch.translatesAutoresizingMaskIntoConstraints = false;
        selectorSwitch.thumbTintColor = UIColor.appBlue;
        return selectorSwitch;
    }()
    
    let globalTitleLabel: NormalUILabel = {
        let globalTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        globalTitleLabel.text = "Global";
        return globalTitleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        setupSelector();
        setupGlobalTitleLabel();
        setupLocalTitleLabel();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupSelector(){
        self.addSubview(selectorSwitch);
        selectorSwitch.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        selectorSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    fileprivate func setupGlobalTitleLabel(){
        self.addSubview(localTitleLabel);
        localTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        localTitleLabel.rightAnchor.constraint(equalTo: self.selectorSwitch.leftAnchor, constant: -5).isActive = true;
        localTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        localTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
    }
    fileprivate func setupLocalTitleLabel(){
        self.addSubview(globalTitleLabel);
        globalTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        globalTitleLabel.leftAnchor.constraint(equalTo: selectorSwitch.rightAnchor, constant: 5).isActive = true;
        globalTitleLabel.centerYAnchor.constraint(equalTo: self.selectorSwitch.centerYAnchor).isActive = true;
        globalTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    
}
