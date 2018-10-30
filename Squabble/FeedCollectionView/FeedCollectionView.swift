//
//  LocalFeedCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol FeedCollectionViewDelegate{
    func toChatPage(chatPage: ChatPage);
}

class FeedCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var localFeedPage: LocalFeed?;
    var globalFeedPage: GlobalFeed?;
    
    var feedCollectionViewDelegate: FeedCollectionViewDelegate?;
    
    var feedReuse = "feedReuse";
    
    var headlines:[Headline]?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0);
        self.backgroundColor = UIColor.veryLightGray;
        self.delegate = self;
        self.dataSource = self;
        self.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: feedReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedReuse, for: indexPath) as! FeedCollectionViewCell;
        let currentHeadline = headlines![indexPath.item];
        cell.setHeadline(headline: currentHeadline);
        cell.setPosterName(posterName: currentHeadline.posterName!);
        cell.setheadline(headline: currentHeadline.headline!);
        cell.setCategory(categoryName: currentHeadline.categoryName!);
        cell.setVotingValue(voteValue: currentHeadline.voteCount!);
        cell.setChatPopulation(population: currentHeadline.chatRoomPopulation!);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(headlines != nil){
            return headlines!.count;
        }
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width-20, height: 130);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout();
        let chatPage = ChatPage(collectionViewLayout: layout);
        chatPage.thisHeadline = headlines![indexPath.row];
        chatPage.hidesBottomBarWhenPushed = true;
        chatPage.title = "Category";
        
        //open a socket to the server, load into the chat room
        self.feedCollectionViewDelegate?.toChatPage(chatPage: chatPage);
        localFeedPage?.resetNavBar();
        
        self.localFeedPage?.navigationController?.pushViewController(chatPage, animated: true);
        self.globalFeedPage?.navigationController?.pushViewController(chatPage, animated: true);
    }
    
}
extension FeedCollectionView{
}
