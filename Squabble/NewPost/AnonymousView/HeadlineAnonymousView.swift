//
//  HeadlineAnonymousView.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class HeadlineAnonymousView: UIView{
    
    var anonymousTitleLabel: NormalUILabel = {
        var anonymousTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        anonymousTitleLabel.text = "Anonymous?";
        return anonymousTitleLabel;
    }()
    
    var usernameTitleLabel: NormalUILabel = {
        var usernameTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        return usernameTitleLabel;
    }()
    
    var onTitleLabel: NormalUILabel = {
        var onTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        onTitleLabel.text = "Username"
        return onTitleLabel;
    }();
    
    var offTitleLabel: NormalUILabel = {
        var offTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        offTitleLabel.text = "Anonymous";
        return offTitleLabel;
    }()
    
    var selectorSwitch: UISwitch = {
        let selectorSwitch = UISwitch();
        selectorSwitch.translatesAutoresizingMaskIntoConstraints = false;
        selectorSwitch.thumbTintColor = .appBlue;
        return selectorSwitch;
    }()
    
//    lazy var anonymousTitleLabel: NormalUILabel = {
//        let anonymousTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 16), textAlign: .center);
//        anonymousTitleLabel.text = "Do you want to be anonymous?";
//        return anonymousTitleLabel;
//    }()
//
//    lazy var anonymousButtonsView: AnonymousButtonsView = {
//        let anonymousButtonsView = AnonymousButtonsView();
//        return anonymousButtonsView;
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
//        setupAnonymousLabel();
        setupSwitch();
//        setupAnonymousTitle();
//        setupButtonsView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupAnonymousLabel(){
        self.addSubview(anonymousTitleLabel);
        anonymousTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        anonymousTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        anonymousTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        anonymousTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true;
    }
    
    fileprivate func setupSwitch(){
        self.addSubview(selectorSwitch);
//        selectorSwitch.topAnchor.constraint(equalTo: self.anonymousTitleLabel.bottomAnchor, constant: 5).isActive = true;
        selectorSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        selectorSwitch.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        
//        selectorSwitch.backgroundColor = UIColor.red;
    
        self.addSubview(onTitleLabel);
        onTitleLabel.rightAnchor.constraint(equalTo: self.selectorSwitch.leftAnchor, constant: -5).isActive = true;
        onTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        onTitleLabel.centerYAnchor.constraint(equalTo: selectorSwitch.centerYAnchor).isActive = true;
        onTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.addSubview(offTitleLabel);
//        offTitleLabel.backgroundColor = UIColor.red;
        offTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        offTitleLabel.leftAnchor.constraint(equalTo: self.selectorSwitch.rightAnchor, constant: 5).isActive = true;
        offTitleLabel.centerYAnchor.constraint(equalTo: selectorSwitch.centerYAnchor).isActive = true;
        offTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
//
//    fileprivate func setupAnonymousTitle(){
//        self.addSubview(anonymousTitleLabel);
//        anonymousTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
//        anonymousTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
//        anonymousTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
//        anonymousTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
//    }
//
//    fileprivate func setupButtonsView(){
//        self.addSubview(anonymousButtonsView);
//        anonymousButtonsView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
//        anonymousButtonsView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
//        anonymousButtonsView.topAnchor.constraint(equalTo: self.anonymousTitleLabel.bottomAnchor, constant: 10).isActive = true;
//        anonymousButtonsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
//    }
    
}
