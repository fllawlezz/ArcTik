//
//  AnonymousButtonsView.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class AnonymousButtonsView: UIView{
    
    lazy var anonymousButton: NormalUIButton = {
        let anonymousButton = NormalUIButton(backgroundColor: .appBlue, title: "Anonymous", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return anonymousButton;
    }()
    
    lazy var notAnonymousButton: NormalUIButton = {
        let notAnonymousButton = NormalUIButton(backgroundColor: .appBlue, title: "Username", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return notAnonymousButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupAnonymousButton();
        setupUserButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupAnonymousButton(){
        self.addSubview(anonymousButton);
        anonymousButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        anonymousButton.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true;
        anonymousButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        anonymousButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupUserButton(){
        self.addSubview(notAnonymousButton);
        notAnonymousButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        notAnonymousButton.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5).isActive = true;
        notAnonymousButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        notAnonymousButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
}
