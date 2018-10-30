//
//  ChangePasswordCell.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ChangePasswordCellDelegate{
    func changePassword();
}

class ChangePasswordCell: UICollectionViewCell{
    
    var delegate: ChangePasswordCellDelegate?;
    
    var changePasswordLabel: NormalUILabel = {
        let changePasswordLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        changePasswordLabel.text = "Change Password";
        return changePasswordLabel;
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = #imageLiteral(resourceName: "arrowToRight");
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
    }()
    
    var selectButton: UIButton = {
        let selectButton = UIButton();
        selectButton.translatesAutoresizingMaskIntoConstraints = false;
//        selectButton.backgroundColor = UIColor.blue;
        return selectButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .white;
        setupPasswordLabel();
        setupImageView();
        setupSelectButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPasswordLabel(){
        self.addSubview(changePasswordLabel);
        changePasswordLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        changePasswordLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        changePasswordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        changePasswordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupImageView(){
        self.addSubview(imageView);
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        imageView.leftAnchor.constraint(equalTo: self.changePasswordLabel.rightAnchor, constant: 5).isActive = true;
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true;
    }
    
    fileprivate func setupSelectButton(){
        self.addSubview(selectButton);
        selectButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        selectButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        selectButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        selectButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        selectButton.addTarget(self, action: #selector(self.handleButtonPressed), for: .touchUpInside);
        
    }
    
}

extension ChangePasswordCell{
    @objc func handleButtonPressed(){
        delegate?.changePassword();
    }
    
    
}
