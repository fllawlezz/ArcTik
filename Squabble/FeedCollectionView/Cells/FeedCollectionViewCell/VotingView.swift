//
//  VotingView.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol VotingViewDelegate{
    func voted(type: Int);
}

class VotingView: UIView{
    
    var delegate: VotingViewDelegate?;
    
    lazy var upvoteButton: NormalUIButton = {
        let upvoteButton = NormalUIButton(backgroundColor: UIColor.white, title: "", font: UIFont.montserratRegular(fontSize: 14), fontColor: UIColor.black);
        upvoteButton.setBackgroundImage(#imageLiteral(resourceName: "upvote"), for: .normal);
        return upvoteButton;
    }();
    
    lazy var downvoteButton: NormalUIButton = {
        let downvoteButton = NormalUIButton(backgroundColor: UIColor.white, title: "", font: UIFont.montserratRegular(fontSize: 14), fontColor: UIColor.black);
        downvoteButton.setBackgroundImage(#imageLiteral(resourceName: "downvote"), for: .normal);
        return downvoteButton;
    }();
    
    lazy var voteCountLabel: NormalUILabel = {
        let votecount = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 18), textAlign: .center);
        votecount.text = "15";
        return votecount;
    }();
    
    var voteCount: Int?;
    var upvotePressed: Bool = false;
    var downvotePressed: Bool = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        //temp;
        voteCount = 0;
        setupVoteCount();
        setupUpvoteButton();
        setupDownvoteButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupVoteCount(){
        self.addSubview(voteCountLabel);
        voteCountLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        voteCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        voteCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        voteCountLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupUpvoteButton(){
        self.addSubview(upvoteButton);
//        upvoteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        upvoteButton.bottomAnchor.constraint(equalTo: self.voteCountLabel.topAnchor, constant: -10).isActive = true;
        upvoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        upvoteButton.heightAnchor.constraint(equalToConstant: 22).isActive = true;
        upvoteButton.widthAnchor.constraint(equalToConstant: 22).isActive = true;
        
        upvoteButton.addTarget(self, action: #selector(self.handleUpVote), for: .touchUpInside);
    }
    
    fileprivate func setupDownvoteButton(){
        self.addSubview(downvoteButton);
//        downvoteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        downvoteButton.topAnchor.constraint(equalTo: self.voteCountLabel.bottomAnchor, constant: 10).isActive = true;
        downvoteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        downvoteButton.heightAnchor.constraint(equalToConstant: 22).isActive = true;
        downvoteButton.widthAnchor.constraint(equalToConstant: 22).isActive = true;
        
        downvoteButton.addTarget(self, action: #selector(self.handleDownVote), for: .touchUpInside);
    }
    
    func setVoteCount(voteCount: Int){
        self.voteCount = voteCount;
        self.voteCountLabel.text = String(voteCount);
    }
    
    func setVoteStatus(voteStatus: Int){
        //-1 if not voted, 0 if downvoted, 1 if upvoted
        if(voteStatus == 0){//downvoted
            setDownVote();
        }else if(voteStatus == 1){
            setUpVote();
        }else{
            setNoVote();
        }
    }
    
}

extension VotingView{
    func setDownVote(){
        self.downvoteButton.setBackgroundImage(#imageLiteral(resourceName: "downVoteFilled"), for: .normal);
        self.upvoteButton.setBackgroundImage(#imageLiteral(resourceName: "upvote"), for: .normal);
        self.downvotePressed = true;
        self.upvotePressed = false;
    }
    
    func setUpVote(){
        self.upvoteButton.setBackgroundImage(#imageLiteral(resourceName: "upVoteFilled"), for: .normal);
        self.downvoteButton.setBackgroundImage(#imageLiteral(resourceName: "downvote"), for: .normal);
        self.upvotePressed = true;
        self.downvotePressed = false;
    }
    
    func setNoVote(){
       upvoteButton.setBackgroundImage(#imageLiteral(resourceName: "upvote"), for: .normal);
        downvoteButton.setBackgroundImage(#imageLiteral(resourceName: "downvote"), for: .normal);
        self.upvotePressed = false;
        self.downvotePressed = false;
    }
    
    @objc func handleUpVote(){
        if(voteCount != nil){
            if(!upvotePressed){
                voteCount! += 1;
                self.voteCountLabel.text = "\(voteCount!)"
                setUpVote();
                self.delegate?.voted(type: 1);
            }
            
        }
        
    }
    
    @objc func handleDownVote(){
        if(voteCount != nil){
            if(!downvotePressed){
                voteCount! -= 1;
                self.voteCountLabel.text = "\(voteCount!)"
                setDownVote();
                self.delegate?.voted(type: 0);
            }
        }
        
    }
}
