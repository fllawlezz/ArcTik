//
//  OtherMessageCell.swift
//  Squabble
//
//  Created by Brandon In on 7/27/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OtherMessageCell: UICollectionViewCell{
    
    lazy var senderNameLabel: NormalUILabel = {
        let senderNameLabel = NormalUILabel(textColor: UIColor.gray, font: UIFont.systemFont(ofSize: 12), textAlign: .left);
        return senderNameLabel;
    }()
    
    lazy var backgroundBubbleView: UIView = {
        let backgroundBubbleView = UIView();
        backgroundBubbleView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundBubbleView.backgroundColor = UIColor.veryLightGray;
        backgroundBubbleView.layer.cornerRadius = 15;
        return backgroundBubbleView;
    }()
    
    lazy var messageTextView: UITextView = {
        let messageTextView = UITextView();
        messageTextView.translatesAutoresizingMaskIntoConstraints = false;
        messageTextView.isEditable = false;
        messageTextView.isScrollEnabled = false;
        messageTextView.font = UIFont.systemFont(ofSize: 14);
        messageTextView.backgroundColor = UIColor.clear;
        return messageTextView;
    }()
    
    var bubbleViewTopAnchor: NSLayoutConstraint?;
    var bubbleViewWidthAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupSenderNameLabel();
        setupBackgroundBubbleView();
        setupMessageTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupSenderNameLabel(){
        self.addSubview(senderNameLabel);
        senderNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        senderNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        senderNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        senderNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        senderNameLabel.text = "Anonymous";
    }
    
    fileprivate func setupBackgroundBubbleView(){
        self.addSubview(backgroundBubbleView);
        backgroundBubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        backgroundBubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        bubbleViewWidthAnchor = backgroundBubbleView.widthAnchor.constraint(equalToConstant: 225);
        bubbleViewWidthAnchor?.isActive = true;
        
        if(self.senderNameLabel.isHidden){
            backgroundBubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        }else{
            backgroundBubbleView.topAnchor.constraint(equalTo: self.senderNameLabel.bottomAnchor, constant: 5).isActive = true;
        }
    }
    
    fileprivate func setupMessageTextView(){
        self.addSubview(messageTextView);
        messageTextView.leftAnchor.constraint(equalTo: self.backgroundBubbleView.leftAnchor, constant: 5).isActive = true;
        messageTextView.rightAnchor.constraint(equalTo: self.backgroundBubbleView.rightAnchor, constant: -5).isActive = true;
        messageTextView.topAnchor.constraint(equalTo: self.backgroundBubbleView.topAnchor, constant: 5).isActive = true;
        messageTextView.bottomAnchor.constraint(equalTo: self.backgroundBubbleView.bottomAnchor).isActive = true;
    }
    
    func setMessage(message: String){
        self.messageTextView.text = message;
    }
    
    func setSenderName(name: String){
        senderNameLabel.text = name;
    }
}
