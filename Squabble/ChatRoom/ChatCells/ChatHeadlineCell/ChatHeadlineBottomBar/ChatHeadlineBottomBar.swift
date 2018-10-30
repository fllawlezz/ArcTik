//
//  ChatHeadlineBottomBar.swift
//  Squabble
//
//  Created by Brandon In on 7/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ChatHeadlineBottomBarDelegate{
    func showFlagAlert();
}

class ChatHeadlineBottomBar: UIView{
    
    var delegate: ChatHeadlineBottomBarDelegate?;
    
    lazy var timeFromPostLabel: NormalUILabel = {
        let timeFromPostLabel = NormalUILabel(textColor: UIColor.gray, font: UIFont.systemFont(ofSize: 14), textAlign: .center);
//        timeFromPostLabel.text = "5 hours";
        return timeFromPostLabel;
    }()
    
    lazy var numberOfPeopleInChatView: NumberOfPeopleInChatView = {
        let numberOfPeopleInChatView = NumberOfPeopleInChatView();
        return numberOfPeopleInChatView;
    }()
    
    lazy var flagButtonBackground: UIView = {
        let flagButtonBackground = UIView();
        flagButtonBackground.translatesAutoresizingMaskIntoConstraints = false;
        flagButtonBackground.backgroundColor = UIColor.white;
        return flagButtonBackground;
    }()
    
    lazy var flagButton: NormalUIButton = {
        let flagButton = NormalUIButton(backgroundColor: UIColor.white, title: "", font: UIFont.systemFont(ofSize: 12), fontColor: UIColor.black);
        flagButton.setBackgroundImage(#imageLiteral(resourceName: "flag"), for: .normal);
        flagButton.contentMode = .center;
        return flagButton;
    }()
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupTimeFromPostLabelSetup();
        numberOfPeopleInChatViewSetup();
        flagButtonSetup();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupTimeFromPostLabelSetup(){
        self.addSubview(timeFromPostLabel);
        timeFromPostLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        timeFromPostLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        timeFromPostLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        timeFromPostLabel.widthAnchor.constraint(equalToConstant: UIscreenWidth!/3).isActive = true;
    }
    
    fileprivate func numberOfPeopleInChatViewSetup(){
        self.addSubview(numberOfPeopleInChatView);
        numberOfPeopleInChatView.leftAnchor.constraint(equalTo: self.timeFromPostLabel.rightAnchor).isActive = true;
        numberOfPeopleInChatView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        numberOfPeopleInChatView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        numberOfPeopleInChatView.widthAnchor.constraint(equalToConstant: UIscreenWidth!/3).isActive = true;
    }
    
    fileprivate func flagButtonSetup(){
        self.addSubview(flagButtonBackground);
        flagButtonBackground.leftAnchor.constraint(equalTo: self.numberOfPeopleInChatView.rightAnchor).isActive = true;
        flagButtonBackground.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        flagButtonBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        flagButtonBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.flagButtonBackground.addSubview(flagButton);
        flagButton.centerXAnchor.constraint(equalTo: self.flagButtonBackground.centerXAnchor).isActive = true;
        flagButton.centerYAnchor.constraint(equalTo: self.flagButtonBackground.centerYAnchor).isActive = true;
        flagButton.heightAnchor.constraint(equalToConstant: 15).isActive = true;
        flagButton.widthAnchor.constraint(equalToConstant: 15).isActive = true;
        
        flagButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15);
        flagButton.addTarget(self, action: #selector(self.handleFlagClicked), for: .touchUpInside);

    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
}

extension ChatHeadlineBottomBar{
    @objc func handleFlagClicked(){
        print("clicked");
        delegate?.showFlagAlert();
    }
}
