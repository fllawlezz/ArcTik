//
//  CustomTabBarController.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    var localFeedNavigation: UINavigationController?;
    var globalFeedNavigation: UINavigationController?;
    var headlineFeedNavigation: UINavigationController?;
    var profileFeedNavigation: UINavigationController?;
    var chatRoomsNavigation: UINavigationController?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
//        checkLoginStatus();
        self.view.backgroundColor = UIColor.white;
        self.delegate = self;
        self.tabBar.isTranslucent = false;
        self.tabBar.tintColor = UIColor.black;
        setupLocalTab();
        setupGlobalTab();
        setupHeadlineTab();
        setupProfileTab();
        setupChatRooms();
        
        viewControllers = [localFeedNavigation!, globalFeedNavigation!, headlineFeedNavigation!, profileFeedNavigation!];
    }
    
    fileprivate func checkLoginStatus(){
        let loginStatus = standard.object(forKey: "login");
        if loginStatus == nil{
            let startingPage = StartingPage();
            let navigationController = UINavigationController(rootViewController: startingPage);
            navigationController.navigationBar.isHidden = true;
            self.present(navigationController, animated: true, completion: nil);
        }
    }
    
    fileprivate func setupLocalTab(){
        let localFeedPage = LocalFeed();
        
        localFeedNavigation = UINavigationController(rootViewController: localFeedPage);
        localFeedNavigation?.navigationBar.isTranslucent = false;
        localFeedNavigation?.navigationBar.barTintColor = UIColor.appBlue;
        localFeedNavigation?.navigationBar.tintColor = UIColor.white;
        localFeedNavigation?.title = "Local";
        localFeedNavigation?.tabBarItem.image = #imageLiteral(resourceName: "localLocation");
        
    }
    
    fileprivate func setupGlobalTab(){
        let globalPage = GlobalFeed();
        let globalFeedTtileView = FeedTitleView(items: ["New","Hot"]);
        
        let searchImage = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: nil, action: nil);
        let composeImage = UIBarButtonItem(image: #imageLiteral(resourceName: "compose"), style: .plain, target: nil, action: nil);
        
        globalFeedNavigation = UINavigationController(rootViewController: globalPage);
        globalFeedNavigation?.navigationBar.isTranslucent = false;
        globalFeedNavigation?.navigationBar.topItem?.titleView = globalFeedTtileView;
        globalFeedNavigation?.navigationBar.barTintColor = UIColor.appBlue;
        globalFeedNavigation?.navigationBar.tintColor = UIColor.white;
        globalFeedNavigation?.title = "Global";
        globalFeedNavigation?.tabBarItem.image = #imageLiteral(resourceName: "globe");
        globalFeedNavigation?.navigationBar.topItem?.leftBarButtonItem = searchImage;
        globalFeedNavigation?.navigationBar.topItem?.rightBarButtonItem = composeImage;
        globalFeedNavigation?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : UIFont.montserratRegular(fontSize: 14)]
    }
    
    fileprivate func setupHeadlineTab(){
        let headlinePage = MyHeadlines();
        
        headlineFeedNavigation = UINavigationController(rootViewController: headlinePage);
        headlineFeedNavigation?.navigationBar.isTranslucent = false;
        headlineFeedNavigation?.navigationBar.barTintColor = UIColor.appBlue;
        headlineFeedNavigation?.navigationBar.tintColor = UIColor.white;
        headlineFeedNavigation?.navigationBar.topItem?.title = "My Posts";
        headlineFeedNavigation?.title = "My Posts";
        headlineFeedNavigation?.tabBarItem.image = #imageLiteral(resourceName: "myHeadline");
        headlineFeedNavigation?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.montserratBold(fontSize: 18)]
    }
    
    fileprivate func setupProfileTab(){
        let profilePage = ProfilePage();
        
        profileFeedNavigation = UINavigationController(rootViewController: profilePage);
        profileFeedNavigation?.navigationBar.isTranslucent = false;
        profileFeedNavigation?.navigationBar.barTintColor = UIColor.appBlue;
        profileFeedNavigation?.navigationBar.tintColor = UIColor.white;
        profileFeedNavigation?.navigationBar.topItem?.title = "Profile";
        profileFeedNavigation?.title = "Profile";
        profileFeedNavigation?.tabBarItem.image = #imageLiteral(resourceName: "profile");
        profileFeedNavigation?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.montserratBold(fontSize: 18)]
    }
    
    fileprivate func setupChatRooms(){
        let chatRoomPage = ProfilePage();
        
        chatRoomsNavigation = UINavigationController(rootViewController: chatRoomPage);
        chatRoomsNavigation?.navigationBar.isTranslucent = false;
        chatRoomsNavigation?.navigationBar.barTintColor = UIColor.appBlue;
        chatRoomsNavigation?.navigationBar.tintColor = UIColor.white;
        chatRoomsNavigation?.navigationBar.topItem?.title = "Chats";
        chatRoomsNavigation?.title = "Chats";
        chatRoomsNavigation?.tabBarItem.image = #imageLiteral(resourceName: "chatRoomTab");
        chatRoomsNavigation?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.montserratBold(fontSize: 18)]
        
    }
    
    
    
    
    
    
}
