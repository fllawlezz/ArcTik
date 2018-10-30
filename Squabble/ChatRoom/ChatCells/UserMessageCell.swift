//
//  ChatUserMessage.swift
//  Squabble
//
//  Created by Brandon In on 7/27/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class UserMessageCell: UICollectionViewCell{
    
    lazy var messageTextView: UITextView = {
        let messageTextView = UITextView();
        messageTextView.translatesAutoresizingMaskIntoConstraints = false;
        messageTextView.font = UIFont.systemFont(ofSize: 14);
        messageTextView.textColor = UIColor.white;
        messageTextView.backgroundColor = UIColor.clear;
        messageTextView.isEditable = false;
        messageTextView.isScrollEnabled = false;
        return messageTextView;
    }()
    
    lazy var backgroundBubbleView: UIView = {
        let backgroundBubbleView = UIView();
        backgroundBubbleView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundBubbleView.backgroundColor = UIColor.appBlue;
        backgroundBubbleView.layer.cornerRadius = 15;
        return backgroundBubbleView;
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupBackgroundBubbleView();
        setupMessageTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupMessageTextView(){
        self.addSubview(messageTextView);
        messageTextView.rightAnchor.constraint(equalTo: self.backgroundBubbleView.rightAnchor, constant: -5).isActive = true;
        messageTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        messageTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        messageTextView.leftAnchor.constraint(equalTo: self.backgroundBubbleView.leftAnchor, constant: 5).isActive = true;
    }
    
    fileprivate func setupBackgroundBubbleView(){
        self.addSubview(backgroundBubbleView);
        backgroundBubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        backgroundBubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        backgroundBubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        bubbleWidthAnchor = backgroundBubbleView.widthAnchor.constraint(equalToConstant: 225);
        bubbleWidthAnchor?.isActive = true;
    }
    
    func setUserMessageText(message: String){
        self.messageTextView.text = message;
    }
    
}
