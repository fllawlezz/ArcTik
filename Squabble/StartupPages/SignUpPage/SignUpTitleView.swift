//
//  SignUpTitleView.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol SignUpTitleViewDelegate{
    func handleClear();
}

class SignUpTitleView: UIView{
    
    var delegate: SignUpTitleViewDelegate?;
    
    lazy var cancelButton: NormalUIButton = {
        let cancelButton = NormalUIButton(backgroundColor: .clear, title: "", font: .montserratRegular(fontSize: 14), fontColor: .black);
        cancelButton.setBackgroundImage(#imageLiteral(resourceName: "whiteClear"), for: .normal);
        cancelButton.tintColor = .white;
        return cancelButton;
    }()
    
    lazy var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .white, font: UIFont.montserratBold(fontSize: 24), textAlign: .center);
        titleLabel.text = "Squabble";
        return  titleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.clear;
        setupCancelButton();
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCancelButton(){
        self.addSubview(cancelButton);
        cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 15).isActive = true;
        cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        cancelButton.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        cancelButton.addTarget(self, action: #selector(self.handleClear), for: .touchUpInside);
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
    }
    
}

extension SignUpTitleView{
    
    @objc func handleClear(){
        self.delegate?.handleClear();
    }
    
}
