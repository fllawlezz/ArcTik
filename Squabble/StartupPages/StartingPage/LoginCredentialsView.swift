//
//  LoginCredentialsView.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol LoginCredentialsDelegate{
    func handleLoginAttempt(email: String, password: String);
//    func handleLoginAttemptFailed();
}

class LoginCredentialsView: UIView {
    
    var delegate: LoginCredentialsDelegate?
    
    lazy var emailField: NormalUITextField = {
        let userNameField = NormalUITextField();
        userNameField.translatesAutoresizingMaskIntoConstraints = false;
        userNameField.font = UIFont.systemFont(ofSize: 16);
        userNameField.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[NSAttributedStringKey.foregroundColor: UIColor.white]);
        userNameField.textColor = UIColor.white;
        userNameField.backgroundColor = UIColor.lightAppBlue;
        userNameField.spellCheckingType = .no;
        userNameField.autocorrectionType = .no;
        return userNameField;
    }()
    
    lazy var passwordField: NormalUITextField = {
        let passwordField = NormalUITextField();
        passwordField.translatesAutoresizingMaskIntoConstraints = false;
        passwordField.font = UIFont.systemFont(ofSize: 16);
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSAttributedStringKey.foregroundColor: UIColor.white]);
        passwordField.textColor = UIColor.white;
        passwordField.backgroundColor = UIColor.lightAppBlue;
        passwordField.isSecureTextEntry = true;
        return passwordField;
    }()
    
    lazy var loginButton: NormalUIButton = {
        let loginButton = NormalUIButton(backgroundColor: UIColor.lightAppBlue, title: "Login", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: .white);
        loginButton.layer.cornerRadius = 0;
        loginButton.layer.borderColor = UIColor.white.cgColor;
        loginButton.layer.borderWidth = 1;
        return loginButton;
    }()
    
    lazy var forgotPasswordLabel: NormalUILabel = {
        let forgotPasswordLabel = NormalUILabel(textColor: .white, font: UIFont.italicSystemFont(ofSize: 12), textAlign: .center);
        forgotPasswordLabel.text = "Forgot Password?";
        return forgotPasswordLabel;
    }()

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupUserNameField();
        setupPasswordField();
        setupLoginButton();
        setupForgotPasswordLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupUserNameField(){
        self.addSubview(emailField);
        emailField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        emailField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        emailField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupPasswordField(){
        self.addSubview(passwordField);
        passwordField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.rightAnchor, constant:-25).isActive = true;
        passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 20).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupLoginButton(){
        self.addSubview(loginButton);
        loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        loginButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 20).isActive = true;
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        loginButton.addTarget(self, action: #selector(handleLoginAttempt), for: .touchUpInside);
    }
    
    fileprivate func setupForgotPasswordLabel(){
        self.addSubview(forgotPasswordLabel);
        forgotPasswordLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        forgotPasswordLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        forgotPasswordLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10).isActive = true;
        forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true;
    }
    
    func resignAll(){
        self.emailField.resignFirstResponder();
        self.passwordField.resignFirstResponder();
    }
    
}

extension LoginCredentialsView{
    
    @objc func handleLoginAttempt(){
//        if(emailField.text!.count > 0 && passwordField.text!.count > 0){
            delegate?.handleLoginAttempt(email: self.emailField.text!, password: passwordField.text!);
//        }else{
//            print("none");
//        }
    }
    
}
