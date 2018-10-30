//
//  ChatHeadlineCell.swift
//  Squabble
//
//  Created by Brandon In on 7/27/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ChatHeadlineCell: UICollectionViewCell{
    
    var chatHeadlineBottomBarDelegate: ChatHeadlineBottomBarDelegate?{
        didSet{
            self.chatLineBottomBar.delegate = self.chatHeadlineBottomBarDelegate;
        }
    }
    
    lazy var userNameLabel: NormalUILabel = {
        let userNameLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        return userNameLabel;
    }()
    
    lazy var headlineTextView: UITextView = {
        let headlineTextView = UITextView();
        headlineTextView.translatesAutoresizingMaskIntoConstraints = false;
        headlineTextView.font = UIFont.montserratRegular(fontSize: 14);
        headlineTextView.textColor = UIColor.black;
        headlineTextView.isEditable = false;
        headlineTextView.isScrollEnabled = false;
        return headlineTextView;
    }()
    
    lazy var chatLineBottomBar: ChatHeadlineBottomBar = {
        let chatLineBottomBar = ChatHeadlineBottomBar();
        return chatLineBottomBar;
    }()
    
    var thisHeadline: Headline?{
        didSet{
            self.setupText();
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupUserNameLabel();
        setupHeadlineTextView();
        setupChatLineBottomBar();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupUserNameLabel(){
        self.addSubview(userNameLabel);
        userNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true;
        userNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        userNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80).isActive = true;
        userNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
//        userNameLabel.text = "Anonymous"
    }
    
    fileprivate func setupHeadlineTextView(){
        self.addSubview(headlineTextView);
        headlineTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        headlineTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        headlineTextView.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 10).isActive = true;
        headlineTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true;
//        headlineTextView.text = "Swarles Barkely destroyed the New York Moons!! He's an awesome player! Like for real, he's like a tremendous basketball player!! MVP!! MVP!! MVP!"
//        print(headlineTextView.text.count);
//        headlineTextView.backgroundColor = UIColor.red;
    }
    
    fileprivate func setupChatLineBottomBar(){
        self.addSubview(chatLineBottomBar);
        chatLineBottomBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        chatLineBottomBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        chatLineBottomBar.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        chatLineBottomBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
//        chatLineBottomBar.delegate = self.chatHeadlineBottomBarDelegate;
    }
    
    func setupText(){
        if let headline = thisHeadline{
            self.userNameLabel.text = headline.posterName!;
            self.headlineTextView.text = headline.headline!;
        }
    }
    
}
