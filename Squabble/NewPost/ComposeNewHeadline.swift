//
//  ComposeNewHeadline.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ComposeNewHeadlineDelegate {
//    func postHeadline(headline: String, name: String, globalOrLocal: Int, categoryName: String);
    func postHeadline(headline: Headline);
}

let categoryPickerNotification = "categoryNotification";


class ComposeNewHeadline: UIViewController, UITextViewDelegate,NewHeadLineTitleViewDelegate, CategoryFieldViewDelegate{

    var delegate: ComposeNewHeadlineDelegate?
    
    lazy var postButton: NormalUIButton = {
        let postButton = NormalUIButton(backgroundColor: UIColor.appBlue, title: "Post Headline", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.white);
        return postButton;
    }()
    
    lazy var backgroundTopCover: UIView = {
        let backgroundTopCover = UIView();
        backgroundTopCover.translatesAutoresizingMaskIntoConstraints = false;
        backgroundTopCover.backgroundColor = UIColor.appBlue;
        return backgroundTopCover;
    }()
    
    lazy var titleView: NewHeadlineTitleView = {
        let titleView = NewHeadlineTitleView();
        titleView.translatesAutoresizingMaskIntoConstraints = false;
        titleView.delegate = self;
        return titleView;
    }()
    
    lazy var newHeadlineView: NewHeadlineView = {
        let newHeadlineView = NewHeadlineView();
//        newHeadlineView.backgroundColor = UIColor.red;
        return newHeadlineView;
    }()
    
    lazy var buttonViews: HeadlineAnonymousView = {
        let buttonViews = HeadlineAnonymousView();
        buttonViews.translatesAutoresizingMaskIntoConstraints = false;
        return buttonViews;
    }()
    
    lazy var localorGlobalView: LocalOrGlobalView = {
        let localOrGlobalView = LocalOrGlobalView();
        return localOrGlobalView;
    }()
    
    lazy var categoryFieldView: CategoryFieldView = {
        let categoryFieldView = CategoryFieldView();
        return categoryFieldView;
    }()
    
//    let categories = ["General","Sports","Politics","Other"];
    var categories:[Category]?;
    var headline: String?
    var name: String?
    var localOrGlobal: Int?;
    var selectedCategory: Category?;
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        addObserver();
        setupTopBackground();
        setupPostButton();
        setupTitleView();
        setupNewHeadlineView();
        setupButtonViews();
        setupLocalOrGlobalView();
        setupPickerView();
        
        self.selectedCategory = Category(categoryName: "General", categoryID: 1);
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObserver(){
        let name = Notification.Name(rawValue: categoryPickerNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(handleScreenUp), name: name, object: nil);
    }
    
    fileprivate func setupPostButton(){
        self.view.addSubview(postButton);
        postButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        postButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        if #available(iOS 11.0, *) {
            postButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            // Fallback on earlier versions
            postButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        };
        postButton.addTarget(self, action: #selector(postHeadline), for: .touchUpInside);
    }
    
    fileprivate func setupTitleView(){
        self.view.addSubview(titleView);
        titleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        titleView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        titleView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        if #available(iOS 11.0, *) {
            titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        };
    }
    
    fileprivate func setupTopBackground(){
        self.view.addSubview(backgroundTopCover);
        backgroundTopCover.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        backgroundTopCover.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        backgroundTopCover.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        backgroundTopCover.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupNewHeadlineView(){
        self.view.addSubview(newHeadlineView);
        newHeadlineView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        newHeadlineView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        newHeadlineView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10).isActive = true;
        newHeadlineView.heightAnchor.constraint(equalToConstant: 225).isActive = true;
        
    }
    
    fileprivate func setupButtonViews(){
        self.view.addSubview(buttonViews);
        buttonViews.topAnchor.constraint(equalTo: self.newHeadlineView.bottomAnchor).isActive = true;
        buttonViews.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        buttonViews.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        buttonViews.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        
    }
    
    fileprivate func setupLocalOrGlobalView(){
        self.view.addSubview(localorGlobalView);
        localorGlobalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        localorGlobalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        localorGlobalView.topAnchor.constraint(equalTo: self.buttonViews.bottomAnchor).isActive = true;
        localorGlobalView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.newHeadlineView.headlineTextView.resignFirstResponder();
        self.categoryFieldView.resignTextField();
        handleScreenDown();
    }
    
    fileprivate func setupPickerView(){
        self.view.addSubview(categoryFieldView);
        categoryFieldView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 45).isActive = true;
        categoryFieldView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -45).isActive = true;
        categoryFieldView.topAnchor.constraint(equalTo: self.localorGlobalView.bottomAnchor, constant: 10).isActive = true;
        categoryFieldView.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        categoryFieldView.categories = self.categories;
        categoryFieldView.categoryFieldDelegate = self;
    }
}

extension ComposeNewHeadline{
    
    fileprivate func getDate()->String{
        let time = Date();
        let timeFormatter = DateFormatter();
        timeFormatter.dateFormat = "MM/dd/yyy hh:mm a";
        timeFormatter.amSymbol = "AM";
        timeFormatter.pmSymbol = "PM";
        let date = timeFormatter.string(from: time);
        return date;
    }
    
    @objc func postHeadline(){
        if(self.newHeadlineView.headlineTextView.text.count > 0){
            //get info
            getAllData();
            let date = getDate();
            //post to server and into the queue
            let url = URL(string: "http://54.202.134.243:3000/post_headline")!
            var urlRequest = URLRequest(url: url);
            let httpBody = "headline=\(self.headline!)&senderName=\(self.name!)&userID=\(self.userID!)&localOrGlobal=\(self.localOrGlobal!)&categoryID=\(selectedCategory!.categoryID)&selectedCategory=\(self.selectedCategory!.categoryName!)&time=\(date)";
    //        print(httpBody);
            urlRequest.httpMethod = "POST";
            urlRequest.httpBody = httpBody.data(using: .utf8);
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
                if(err != nil){
                    //show error
                    DispatchQueue.main.async {
                        self.showNetworkError();
                        return;
                    }

                }

                if(data != nil){
                    let response = NSString(data: data!, encoding: 8);
    //                print(response);
                    if(response != "error"){
                        
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                            
                            let headlineID = json["headlineID"] as! Int;
                            let chatRoomID = json["chatRoomID"] as! Int;
                            
                            DispatchQueue.main.async {
                                let newHeadline = Headline(headline: self.headline!, headlineID: String(headlineID), chatRoomID: chatRoomID,posterName: "Me", categoryName: self.selectedCategory!.categoryName!, categoryID: self.selectedCategory!.categoryID, voteCount: 0, chatRoomPopulation: 0, globalOrLocal: 0);
                                self.delegate?.postHeadline(headline: newHeadline);
                                self.dismiss(animated: true, completion: nil);
                            }
                            
                        }catch{
                            print("error");
                        }
                        
                        //add the post to the feed
                        
                        
                    }else{
                        //show error
                        DispatchQueue.main.async {
                            self.showPostError()
                        }
                    }
                }
            }
            task.resume();
        }
    }
    
    func showNetworkError(){
        let alert = UIAlertController(title: "Oops!", message: "You can't post this for right now... its a server problem :(. Try again later...", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func showPostError(){
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong posting this! Please try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func didCancel() {
        self.newHeadlineView.headlineTextView.resignFirstResponder();
        self.dismiss(animated: true, completion: nil);
    }
    
    
    @objc func handleScreenUp(){
        if(UIscreenWidth == 320){
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y -= 150;
            }
        }
    }
    
    @objc func handleScreenDown(){
        if(UIscreenWidth == 320){
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0;
            }
        }
    }
    
    
}

extension ComposeNewHeadline{
    func setCategory(category: Category) {
        self.selectedCategory = category;
    }
    
    func getAllData(){
        self.headline = newHeadlineView.headlineTextView.text!;
        if(self.buttonViews.selectorSwitch.isOn){
            self.name = "Anonymous";
        }else{
            self.name = standard.object(forKey: "userName") as? String;
        }
        
        if(self.localorGlobalView.selectorSwitch.isOn){
            self.localOrGlobal = 1;
        }else{
            self.localOrGlobal = 0;
        }
        
        self.userID = standard.object(forKey: "userID") as? String
    }
    
}
