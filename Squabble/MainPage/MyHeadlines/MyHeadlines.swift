//
//  File.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let reloadMyHeadlinesNotification = "reloadMyHeadlinesNotification";

class MyHeadlines:UIViewController, FeedCollectionViewDelegate{
    
    let refreshControl = UIRefreshControl();
    
    var headlines = [Headline]();
    
    lazy var myFeedCollectionView: FeedCollectionView = {
        let flowLayout = UICollectionViewFlowLayout();
        let myFeedCollectionView = FeedCollectionView(frame: .zero, collectionViewLayout: flowLayout);
        myFeedCollectionView.myHeadlinesPage = true;
        return myFeedCollectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        addObservers()
        setupMyFeedCollectionView();
    }
    
    fileprivate func setupMyFeedCollectionView(){
        self.view.addSubview(myFeedCollectionView);
        myFeedCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        myFeedCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        myFeedCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        myFeedCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        myFeedCollectionView.headlines = self.headlines;
        myFeedCollectionView.feedCollectionViewDelegate = self;
        
        myFeedCollectionView.refreshControl = self.refreshControl;
        refreshControl.beginRefreshing();
        refreshControl.addTarget(self, action: #selector(self.getMyPosts), for: .valueChanged);
        getMyPosts();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: reloadMyHeadlinesNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadMyHeadlines(notification:)), name: name, object: nil);
    }
    
    @objc func getMyPosts(){
        if(self.headlines.count > 0){
            self.headlines.removeAll();
        }
        let userID = standard.object(forKey: "userID") as! String;
        let url = URL(string: "http://54.202.134.243:3000/load_myHeadlines")!
        var request = URLRequest(url: url);
        let postBody = "userID=\(userID)"
        request.httpBody = postBody.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if(err != nil){
                //show error
                DispatchQueue.main.async {
                    self.showErrorAlert();
                }
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response != "error"){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
//                        print(json);
                        
                        DispatchQueue.main.async {
                            //headlineIDs,posterIDs,posterNames,descriptions,upVotes,downVotes,chatRoomPopulations,categories
                            let headlineIDs = json["headlineIDs"] as! NSArray;
                            let posterIDs = json["posterIDs"] as! NSArray;
                            let posterNames = json["posterNames"] as! NSArray;
                            let descriptions = json["descriptions"] as! NSArray;
                            let upVotes = json["upVotes"] as! NSArray;
                            let downVotes = json["downVotes"] as! NSArray;
                            let chatRoomPopulations = json["chatRoomPopulations"] as! NSArray;
                            let categories = json["categories"] as! NSArray;
                            let categoryIDs = json["categoryIDs"] as! NSArray;
                            let chatRoomIDs = json["chatRoomIDs"] as! NSArray;
                            
                            var count = 0;
                            while(count<headlineIDs.count){
                                
                                let headlineID = String(headlineIDs[count] as! Int);
                                _ = String(posterIDs[count] as! Int);
                                let posterName = posterNames[count] as! String;
                                let description = descriptions[count] as! String;
                                let upVote = upVotes[count] as! Int;
                                let downVote = downVotes[count] as! Int;
                                let chatRoomPop = chatRoomPopulations[count] as! Int;
                                let category = categories[count] as! String;
                                let categoryID = categoryIDs[count] as! Int;
                                let chatRoomID = chatRoomIDs[count] as! Int
                                
                                let totalVoteCount = upVote - downVote;
                                
                                let newHeadline = Headline(headline: description, headlineID: headlineID, chatRoomID: chatRoomID, posterName: posterName, categoryName: category, categoryID: categoryID, voteCount: totalVoteCount, chatRoomPopulation: chatRoomPop, globalOrLocal: 0);
                                
                                self.headlines.append(newHeadline);
                                print(self.headlines[count].headlineID!);
                                print(self.headlines[count].headline!);
                                count+=1;
                            }
                            
                            DispatchQueue.main.async {
                                
                                self.myFeedCollectionView.headlines = self.headlines;
                                self.myFeedCollectionView.reloadData();
                                
                                self.refreshControl.endRefreshing();
                                
                            }
                            
                            
                            
                        }
                    }catch{
                        print("error");
                    }
                }else{
                    //show error loading
                    DispatchQueue.main.async {
                        self.showLoadingError();
                    }
                }
            }
        }
        task.resume();
    }
    
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "It seems there was an error connecting to our servers... try again later ", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.refreshControl.endRefreshing();
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    func showLoadingError(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "It seems there was an error retrieving your posts... try again later ", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.refreshControl.endRefreshing();
        }))
        self.present(alert, animated: true, completion: nil);
    }
}

extension MyHeadlines{
    func toChatPage(chatPage: ChatPage) {
        self.navigationController?.pushViewController(chatPage, animated: true);
    }
    
    @objc fileprivate func reloadMyHeadlines(notification: NSNotification){
        if let info = notification.userInfo{
            let newHeadline = info["headline"] as! Headline;
            print(newHeadline.headline!);
            print(newHeadline.headlineID!);
            
            
            self.headlines.insert(newHeadline, at: 0);
            self.myFeedCollectionView.headlines = self.headlines;
            self.myFeedCollectionView.reloadData();
        }
        
    }
    
}
