//
//  ChangePasswordPage1.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ChangePasswordPage1: UIViewController{
    
    lazy var backgroundView: UIView = {
        var backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        return backgroundView;
    }()
    
    lazy var currentPasswordTitleLabel: NormalUILabel = {
        let currentPasswordTitleLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        currentPasswordTitleLabel.text = "Enter Current Password";
        return currentPasswordTitleLabel;
    }()
    
    lazy var passwordTextField: NormalUITextField = {
        let passwordTextField = NormalUITextField();
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false;
        passwordTextField.font = .systemFont(ofSize: 16);
        passwordTextField.textColor = UIColor.black;
        passwordTextField.placeholder = "Current Password";
        passwordTextField.backgroundColor = .veryLightGray;
        passwordTextField.isSecureTextEntry = true;
        passwordTextField.textAlignment = .center;
        return passwordTextField;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .veryLightGray;
        setupNavBar();
        setupBackgroundView();
        setupTitleLabel();
        setupPasswordTextField();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Change Password";
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil);
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.handleNext));
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        self.navigationItem.rightBarButtonItem = nextButton;
    }
    
    fileprivate func setupBackgroundView(){
        self.view.addSubview(backgroundView);
        backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        backgroundView.heightAnchor.constraint(equalToConstant: 110).isActive = true;
    }
    
    fileprivate func setupTitleLabel(){
        view.addSubview(currentPasswordTitleLabel);
        currentPasswordTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25).isActive = true;
        currentPasswordTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true;
        currentPasswordTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        currentPasswordTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupPasswordTextField(){
        view.addSubview(passwordTextField);
        passwordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true;
        passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true;
//        passwordTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true;
//        passwordTextField.centerXAnchor.constraint(equalTo: self.currentPasswordTitleLabel.centerXAnchor).isActive = true;
        passwordTextField.topAnchor.constraint(equalTo: currentPasswordTitleLabel.bottomAnchor, constant: 10).isActive = true;
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
    }
    
}

extension ChangePasswordPage1{
    
    @objc func handleNext(){
        let changePasswordPage2 = ChangePasswordPage2();
        self.navigationController?.pushViewController(changePasswordPage2, animated: true);
    }
    
}
