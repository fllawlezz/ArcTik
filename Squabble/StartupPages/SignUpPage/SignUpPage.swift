//
//  SignUpPage.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let keyboardUpNotification = Notification.Name("keyboardUp");
let keyboardDownNotification = Notification.Name("keyboardDown");


class SignUpPage: UIViewController, SignUpTitleViewDelegate, SignUpBottomViewDelegate{
    
    lazy var signUpTitleView: SignUpTitleView = {
        let signUpTitleView = SignUpTitleView();
        return signUpTitleView;
    }()
    
    lazy var signUpCollectionView: SignUpCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let signUpCollectionView = SignUpCollectionView(frame: .zero, collectionViewLayout: layout);
        return signUpCollectionView;
    }()
    
    lazy var signUpBottomView: SignUpBottomView = {
        let signUpBottomView = SignUpBottomView();
        return signUpBottomView;
    }()
    
    var userName: String?;
    var firstName: String?;
    var lastName: String?;
    var email: String?;
    var password: String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        createObservers();
        setupSignUpTitle();
        setupCollectionView();
        setupBottomView();
    }
    
    fileprivate func setupSignUpTitle(){
        self.view.addSubview(signUpTitleView);
        signUpTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpTitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        if #available(iOS 11.0, *) {
            signUpTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            signUpTitleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        };
        signUpTitleView.delegate = self;
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(signUpCollectionView);
        signUpCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpCollectionView.topAnchor.constraint(equalTo: self.signUpTitleView.bottomAnchor).isActive = true;
        signUpCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true;
        
        signUpCollectionView.signUpPage = self;
    }
    
    fileprivate func setupBottomView(){
        self.view.addSubview(signUpBottomView);
        signUpBottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpBottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpBottomView.topAnchor.constraint(equalTo: self.signUpCollectionView.bottomAnchor, constant: 15).isActive =  true;
        signUpBottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        
        signUpBottomView.bottomViewDelegate = self;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.signUpCollectionView.resignAll();
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0;
        }
    }
    
    fileprivate func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: keyboardUpNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: keyboardDownNotification, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc func keyboardWillShow(notification: Notification){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -50;
        }
    }
    
    @objc func keyboardDown(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0;
        }
    }
}

extension SignUpPage{
    func handleClear() {
        self.navigationController?.popViewController(animated: true);
    }
    
    func handleSubmit(){
        //get all
        self.signUpCollectionView.getAllFieldData();
        if(self.userName != nil && self.firstName != nil && self.lastName != nil && self.email != nil && self.password != nil){
            if(userName!.count > 3 && firstName!.count > 0 && lastName!.count > 0 && email!.count > 3 && password!.count > 6){
                //sign up
                let url = URL(string: "http://54.202.134.243:3000/user_signUp")!
                var request = URLRequest(url: url);
                let postBody = "userName=\(userName!)&firstName=\(firstName!)&lastName=\(lastName!)&email=\(email!)&password=\(password!)"
                request.httpBody = postBody.data(using: .utf8);
                request.httpMethod = "POST";
                let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                    if(err != nil){
                        DispatchQueue.main.async {
                            self.showErrorAlert();
                            return;
                        }
                    }
                    //get the userID
                    if(data != nil){
                        let response = NSString(data: data!, encoding: 8);
                        print(response!);
                        DispatchQueue.main.async {
                            if(response == "exists"){
                                //show alert
                                self.showSignUpExists();
                                return;
                            }else{
                                standard.set("1", forKey: "login");
                                //save user credentials
                                saveStandards(userName: self.userName!, firstName: self.firstName!, lastName: self.lastName!, email: self.email!, password: self.password!, userID: response! as String);
                                //to the main customTabBarPage
                                let customTabBarController = CustomTabBarController();
                                self.present(customTabBarController, animated: true, completion: nil);

                            }
                        }//dispatch quee
                    }
                }
                task.resume();
            }else{
                showSignUpAlert();
            }
        }
    }
    
    func showSignUpAlert(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "There was a problem signing you up! Check to make sure all fields are filled out and your password is at least 7 characters long! ", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func showSignUpExists(){
        let alert = UIAlertController(title: "Account Exists", message: "It seems that the account you are trying to create exists. Please login instead!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "There was a problem connecting with our servers!! Try again later...", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
