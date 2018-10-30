//
//  numberOfPeopleInChatView.swift
//  Squabble
//
//  Created by Brandon In on 7/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let updateChatPopulationNotification = "updateChatPopulationNotification";

class NumberOfPeopleInChatView: UIView{
    
    lazy var numberOfPeopleInChatLabel: NormalUILabel = {
        let numberOfPeopleInChatLabel = NormalUILabel(textColor: UIColor.gray, font: UIFont.systemFont(ofSize: 12), textAlign: .center);
//        numberOfPeopleInChatLabel.text = "5/100";
//        numberOfPeopleInChatLabel.backgroundColor = UIColor.red;
        return numberOfPeopleInChatLabel;
    }()
    
    lazy var chatImage: UIImageView = {
        let chatImage = UIImageView();
        chatImage.translatesAutoresizingMaskIntoConstraints = false;
        chatImage.image = #imageLiteral(resourceName: "chatRoom");
        return chatImage;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        addObservers();
        setupNumberOfPeopleInChatLabel();
//        setupChatImage();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func addObservers(){
        let name = Notification.Name(rawValue: updateChatPopulationNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateChatPopulation(notification:)), name: name, object: nil);
    }
    
    fileprivate func setupNumberOfPeopleInChatLabel(){
        self.addSubview(numberOfPeopleInChatLabel);
        numberOfPeopleInChatLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        numberOfPeopleInChatLabel.widthAnchor.constraint(equalToConstant: UIscreenWidth!/3).isActive = true;
        numberOfPeopleInChatLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        numberOfPeopleInChatLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        let attachedImage = NSTextAttachment();
        attachedImage.image = #imageLiteral(resourceName: "chatRoom");
        attachedImage.bounds = CGRect(x: 0, y: -4, width: 15, height: 15);
        
        let attachmentString = NSAttributedString(attachment: attachedImage);
        let usersText = NSMutableAttributedString(string: "5/100 ");
        usersText.append(attachmentString);
        
        self.numberOfPeopleInChatLabel.attributedText = usersText;
        
    }
    
    @objc func updateChatPopulation(notification:NSNotification){
        if let info = notification.userInfo{
            let population = info["population"] as! Int;
            
            let attachedImage = NSTextAttachment();
            attachedImage.image = #imageLiteral(resourceName: "chatRoom");
            attachedImage.bounds = CGRect(x: 0, y: -4, width: 15, height: 15);
            
            let attachmentString = NSAttributedString(attachment: attachedImage);
            let usersText = NSMutableAttributedString(string: "\(population)/100 ");
            usersText.append(attachmentString);
            
            self.numberOfPeopleInChatLabel.attributedText = usersText;
        }
    }
    
}
