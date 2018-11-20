//
//  LocalFeed.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import CoreData

class LocalFeed: UIViewController, UITextFieldDelegate,ComposeNewHeadlineDelegate, ChatPageDelegate{
    
    lazy var localFeed: FeedCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let localFeed = FeedCollectionView(frame: .zero, collectionViewLayout: layout);
        return localFeed;
    }()
    
    let refreshControl = UIRefreshControl();
    
    
    var headlines = [Headline]();
    var hotHeadlines = [Headline]();
    
    var localFeedTitleView: UISegmentedControl?;
    var composeButton: UIButton?;
    var searchButton: UIButton?;
    var searchBar: NormalUITextField?;
    
    var categories = [Category]();
    
    //collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        addObservers();
        self.view.backgroundColor = UIColor.white;
        self.view.snapshotView(afterScreenUpdates: true);
        setupCategories();
        setupNavBar();
        setupLocalFeed();
        setupRefreshControl();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: voteSendErrorNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.showErrorAlert), name: name, object: nil);
    }
    
    fileprivate func setupCategories(){
        
        let general = Category(categoryName: "General", categoryID: 1);
        let sports = Category(categoryName: "Sports", categoryID: 2);
        let politics = Category(categoryName: "Politics", categoryID: 3);
        let other = Category(categoryName: "Other", categoryID: 4);
        
        categories.append(general);
        categories.append(sports);
        categories.append(politics);
        categories.append(other);
    }
    
    fileprivate func setupNavBar(){
        localFeedTitleView = FeedTitleView(items: ["New","Hot"]);
        localFeedTitleView?.addTarget(self, action: #selector(self.selectorValueChanged), for: .valueChanged);
        
        self.navigationItem.titleView = localFeedTitleView;
        
        searchButton = UIButton(type: .system);
        searchButton!.setImage(#imageLiteral(resourceName: "search"), for: .normal);
        searchButton!.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        searchButton!.addTarget(self, action: #selector(self.handleSearchPressed), for: .touchUpInside);
        
        composeButton = UIButton(type: .system);
        composeButton!.setImage(#imageLiteral(resourceName: "compose"), for: .normal);
        composeButton!.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        composeButton?.addTarget(self, action: #selector(self.handleComposeHeadline), for: .touchUpInside);
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchButton!);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: composeButton!);
        
        searchBar = NormalUITextField();
        searchBar!.backgroundColor = .white;
        searchBar!.layer.cornerRadius = 5;
        searchBar!.placeholder = "Search Names/Categories";
        searchBar!.font = UIFont.montserratRegular(fontSize: 14)
        searchBar!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width*(2/3), height: 25);
        searchBar!.delegate = self;
        searchBar!.returnKeyType = .search;
        
    }
    
    fileprivate func setupLocalFeed(){
        localFeed.localFeedPage = self;
        self.view.addSubview(localFeed);
        localFeed.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        localFeed.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        localFeed.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        localFeed.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        localFeed.headlines = self.headlines;
    }
    
    fileprivate func setupRefreshControl(){
        self.localFeed.refreshControl = self.refreshControl;
        refreshControl.addTarget(self, action: #selector(self.refreshControlRefresh), for: .valueChanged);
        self.localFeed.refreshControl!.beginRefreshing();
        refreshHeadlines();
    }
    
    @objc func handleSearchPressed(){
        let cancelButton = UIButton(type: .system);
        cancelButton.frame = CGRect(x: 0, y: 0, width: 50, height: 40);
        cancelButton.setTitle("cancel", for: .normal);
        cancelButton.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside);
        
        localFeedTitleView?.isHidden = true;
        composeButton?.isHidden = true; 
        searchButton?.isHidden = true;
        
        self.localFeed.headlines = nil;
        self.localFeed.reloadData();
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: searchBar!), animated: true);
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: cancelButton), animated: true);
        
        searchBar?.becomeFirstResponder();
    }
    
    @objc func handleCancel(){
        let searchImageButton = UIButton(type: .system);
        searchImageButton.setImage(#imageLiteral(resourceName: "search"), for: .normal);
        searchImageButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        searchImageButton.addTarget(self, action: #selector(self.handleSearchPressed), for: .touchUpInside);
        
        self.searchBar?.text = "";

        self.localFeedTitleView?.isHidden = false;
        self.composeButton?.isHidden = false;
        self.searchButton?.isHidden = false;
        
        let segmentIndex = self.localFeedTitleView!.selectedSegmentIndex;
        if(segmentIndex == 0){
            self.localFeed.headlines = self.headlines;
            self.localFeed.reloadData();
        }else{
            self.localFeed.headlines = self.hotHeadlines;
            self.localFeed.reloadData();
        }
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: searchButton!), animated: true);
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: composeButton!), animated: true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func resetNavBar(){
        let searchImageButton = UIButton(type: .system);
        searchImageButton.setImage(#imageLiteral(resourceName: "search"), for: .normal);
        searchImageButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25);
        searchImageButton.addTarget(self, action: #selector(self.handleSearchPressed), for: .touchUpInside);
        
        self.searchBar?.text = "";
        
        self.localFeedTitleView?.isHidden = false;
        self.composeButton?.isHidden = false;
        self.searchButton?.isHidden = false;
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: searchButton!), animated: false);
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: composeButton!), animated: false);
    }
    
    @objc func handleComposeHeadline(){
        let composePage = ComposeNewHeadline();
        composePage.categories = self.categories;
        composePage.delegate = self;
        self.present(composePage, animated: true, completion: nil);
    }
    
}

extension LocalFeed{

    func postHeadline(headline: Headline) {
//        print(headline.headline!);
        let newHeadline = Headline(headline: headline.headline!, headlineID: headline.headlineID!, chatRoomID: headline.chatRoomID!, posterName: headline.posterName!, categoryName: headline.categoryName!, categoryID: headline.categoryID!, voteCount: headline.voteCount!, chatRoomPopulation: headline.chatRoomPopulation!, globalOrLocal: headline.globalOrLocal!, liked: 0);
        
        if(headline.globalOrLocal == 0){
            if(self.headlines.count > 0){
                self.headlines.insert(newHeadline, at: 0);
                self.localFeed.headlines = self.headlines;
                let insertIndex = IndexPath(item: 0, section: 0);
                self.localFeed.insertItems(at: [insertIndex]);
            }else{
                self.headlines.append(headline);
                self.localFeed.headlines = self.headlines;
                self.localFeed.reloadData();
            }
            
            
            let name = Notification.Name(rawValue: reloadMyHeadlinesNotification);
            let info = ["headline":newHeadline];
            NotificationCenter.default.post(name: name, object: nil, userInfo: info);
        }
    }
    
    func resetNavigationBar(){
        self.resetNavBar();
    }
}

extension LocalFeed{
    
    @objc func refreshControlRefresh(){
        if(self.localFeedTitleView?.selectedSegmentIndex == 0){
            //refresh the new/normal headlines
            self.refreshHeadlines();
        }else{
            //refresh the hot headlines
            self.refreshHotHeadlines();
        }
    }
    
    @objc func refreshHeadlines(){
        if(self.headlines.count > 0){
            self.headlines.removeAll();
        }
        let userID = standard.object(forKey: "userID") as! String;
        let url = URL(string: "http://54.202.134.243:3000/load_Local_headlines")!
        var request = URLRequest(url: url);
        let postBody = "userID=\(userID)&latitude=\(userLatitude!)&longitude=\(userLongtitude!)"
        print(postBody);
        request.httpBody = postBody.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if(err != nil){
                //show error
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing();
                    self.showErrorAlert();
                }
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response != "error"){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
//                            print(json);
                        
                        DispatchQueue.main.async {
                            //headlineIDs,posterIDs,posterNames,descriptions,upVotes,downVotes,chatRoomPopulations,categories, liked
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
                            let liked = json["liked"] as! NSArray;
                            
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
                                let chatRoomID = chatRoomIDs[count] as! Int;
                                let likedStatus = liked[count] as! Int;
                                
                                let totalVoteCount = upVote - downVote;
                                
                                let newHeadline = Headline(headline: description, headlineID: headlineID,chatRoomID: chatRoomID, posterName: posterName, categoryName: category, categoryID: categoryID, voteCount: totalVoteCount, chatRoomPopulation: chatRoomPop, globalOrLocal: 0, liked: likedStatus);
                                
                                self.headlines.append(newHeadline);
                                count+=1;
                            }
                            self.localFeed.headlines = self.headlines;
                            self.localFeed.reloadData();
                            
                            self.refreshControl.endRefreshing();
                            
                            
                
                        }
                    }catch{
                        
                        DispatchQueue.main.async {
                            self.refreshControl.endRefreshing();
                            self.showErrorAlert();
                        }
                    }
                }else{
                    //show error loading
                }
            }
        }
        task.resume();
    }
    
    func refreshHotHeadlines(){
        print("refresh Hot Headlines");
        self.hotHeadlines.removeAll();
        let userID = standard.object(forKey: "userID") as! String;
        let url = URL(string: "http://54.202.134.243:3000/load_hottestLocalHeadlines")!
        var request = URLRequest(url: url);
        let postBody = "userID=\(userID)&latitude=\(userLatitude!)&longitude=\(userLongtitude!)"
        request.httpBody = postBody.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if(err != nil){
                //show error
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing();
                    self.showErrorAlert();
                }
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response != "error"){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
                        DispatchQueue.main.async {                                //headlineIDs,posterIDs,posterNames,descriptions,upVotes,downVotes,chatRoomPopulations,categories
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
                            let liked = json["likeStatus"] as! NSArray;
                            
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
                                let chatRoomID = chatRoomIDs[count] as! Int;
                                let likedStatus = liked[count] as! Int;
                                
                                let totalVoteCount = upVote - downVote;
                                
                                let newHeadline = Headline(headline: description, headlineID: headlineID,chatRoomID: chatRoomID, posterName: posterName, categoryName: category, categoryID: categoryID, voteCount: totalVoteCount, chatRoomPopulation: chatRoomPop, globalOrLocal: 0, liked: likedStatus);
                                
                                self.hotHeadlines.append(newHeadline);
                                count+=1;
                            }
                            
                            self.refreshControl.endRefreshing();
                            self.localFeed.headlines = self.hotHeadlines;
                            self.localFeed.reloadData();
                            
                        }
                    }catch{
                        
                        DispatchQueue.main.async {
                            self.refreshControl.endRefreshing();
                            self.showErrorAlert();
                        }
                    }
                }else{
                    //show error loading
                }
            }
        }
        task.resume();
    }
    
    @objc func showErrorAlert(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "It seems there was an error connecting to our servers... try again later ", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.refreshControl.endRefreshing();
        }))
        self.present(alert, animated: true, completion: nil);
    }
}

extension LocalFeed{
    //MARK: Navigation Controller Functions
    @objc func selectorValueChanged(){
        if(self.localFeedTitleView!.selectedSegmentIndex == 0){//localFeed
//            print("0");
            self.localFeed.headlines = self.headlines;
            self.localFeed.reloadData();
        }else{
//            print("1");
            self.loadHotHeadlines();
        }
    }
    
    
    @objc func loadHotHeadlines(){
        if(hotHeadlines.count == 0){
            refreshHotHeadlines()
        }else{
            self.refreshControl.endRefreshing()
            self.localFeed.headlines = self.hotHeadlines;
            localFeed.reloadData();
        }
    }
    
    
}
