//
//  StartingPage.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class StartingPage:UIViewController,SignUpViewDelegate,LoginCredentialsDelegate{
    
    lazy var titleView: StartingPageTitleView = {
        let titleView = StartingPageTitleView();
        return titleView;
    }()
    
    lazy var loginCredentialsView: LoginCredentialsView = {
        let loginCredentialsView = LoginCredentialsView();
        return loginCredentialsView;
    }()
    
    lazy var signUpView: SignUpView = {
        let signUpView = SignUpView();
        return signUpView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        setupTitleView();
        setupLoginCredentialsView();
        setupSignUpView();
    }
    
    fileprivate func setupTitleView(){
        self.view.addSubview(titleView);
        titleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        titleView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        titleView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        if #available(iOS 11.0, *) {
            titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        } else {
            // Fallback on earlier versions
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        };
        
    }
    
    fileprivate func setupLoginCredentialsView(){
        self.view.addSubview(loginCredentialsView);
        loginCredentialsView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        loginCredentialsView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        loginCredentialsView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20).isActive = true;
        loginCredentialsView.heightAnchor.constraint(equalToConstant: 195).isActive = true;
        
        loginCredentialsView.delegate = self;
    }
    
    fileprivate func setupSignUpView(){
        self.view.addSubview(signUpView);
        signUpView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        if #available(iOS 11.0, *) {
            signUpView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            signUpView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        };
        signUpView.delegate = self;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loginCredentialsView.resignAll();
    }
    
}

extension StartingPage{
    
    func handleSignUp() {
        let signUpPage = SignUpPage();
        self.navigationController?.pushViewController(signUpPage, animated: true);
    }
    
    func handleLoginAttempt(email: String, password: String) {
        //check if the fields are filled out
        if(email.count > 0 && password.count > 0){
            //check site
            let url = URL(string: "http://54.202.134.243:3000/user_login")!;
            var request = URLRequest(url: url);
            let postBody = "email=\(email)&password=\(password)";
            request.httpBody = postBody.data(using: .utf8) ;
            request.httpMethod = "POST";
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if(err != nil){
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Oops!", message: "Something went wrong with connecting to our servers! Try again later", preferredStyle: .alert);
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        return;
                    }
                }
                
                
                
                if(data != nil){
                    let response = NSString(data: data!, encoding: 8);
                    if(response == "none"){
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Oops", message: "Your email and password don't match", preferredStyle: .alert);
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                        }
                        
                    }else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                            
//                            print(json);
                            
                            DispatchQueue.main.async {
                                //save username, first name, lastName, password, email,
                                let userName = json["userName"] as! String;
                                let firstname = json["firstName"] as! String;
                                let lastName = json["lastName"] as! String;
                                let userID = String(json["userID"] as! Int);
                                
                                
                                standard.set("1", forKey: "login");
                                saveStandards(userName: userName, firstName: firstname, lastName: lastName, email: email, password: password, userID: userID);
                                //then go to main page
                                let customTabBarController = CustomTabBarController();
                                self.present(customTabBarController, animated: true, completion: nil);
                            }
                        }catch{
                            print("error");
                        }
                    }
                }
            }
            task.resume()
        }else{
            let alert = UIAlertController(title: "Oops", message: "Please fill out all fields!", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
    }
    
}
