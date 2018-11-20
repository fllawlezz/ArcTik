//
//  LocalFeedCollectionViewCell.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let voteSendErrorNotification = "VoteSendErrorNotification";

class FeedCollectionViewCell: UICollectionViewCell, VotingViewDelegate{
    
    let headlineText = "I can't believe that people would believe that trump is a bad president. I think he's an awesome president, and that he's doing great !!!!!!";
    
    lazy var votingView: VotingView = {
        let votingView = VotingView();
        return votingView;
    }()
    
    lazy var userImageView: UIImageView = {
        let userImageView = UIImageView();
        userImageView.translatesAutoresizingMaskIntoConstraints = false;
        userImageView.image = #imageLiteral(resourceName: "pig");
        userImageView.layer.cornerRadius = 7.5;
        return userImageView;
    }()
    
    lazy var posterNameLabel: NormalUILabel = {
        let posterName = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        posterName.text = "Anonymous";
        return posterName;
    }()
    
    lazy var categoryNameLabel: NormalUILabel = {
        let categoryNameLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .right);
        categoryNameLabel.text = "Automotive";
        return categoryNameLabel;
    }();
    
    lazy var headlineLabel: UITextView = {
        let headlineLabel = UITextView();
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false;
        headlineLabel.font = UIFont.systemFont(ofSize: 14);
        headlineLabel.textColor = UIColor.black;
        headlineLabel.isScrollEnabled = false;
        headlineLabel.isEditable = false;
        headlineLabel.isUserInteractionEnabled = false;
        return headlineLabel;
    }()
    
    lazy var numberOfPeopleInChatRoom: NormalUILabel = {
        let numberOfPeopleInChatRoom = NormalUILabel(textColor: UIColor.darkGray, font: UIFont.montserratRegular(fontSize: 12), textAlign: .right);
        numberOfPeopleInChatRoom.text = "5/100";
        return numberOfPeopleInChatRoom;
    }()
    
    lazy var chatRoomImage: UIImageView = {
        let chatRoomImage = UIImageView();
        chatRoomImage.translatesAutoresizingMaskIntoConstraints = false;
        chatRoomImage.image = #imageLiteral(resourceName: "chatRoom");
        return chatRoomImage;
    }()
    
    var cellHeadline: Headline?{
        didSet{
            self.setVotingStatus();
        }
    }
    
    var posterName: String?;
    var headline: String?;
    var categoryName: String?;
    var categoryID: Int?;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupVotingView();
        setupUserImage();
        setupPosterNameLabel();
        setupCategoryNameLabel();
        setupHeadlineLabel();
        setupNumberOfPeople();
        setupChatImage();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupVotingView(){
        self.addSubview(votingView);
        votingView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        votingView.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        votingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        votingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        votingView.delegate = self;
    }
    
    fileprivate func setupUserImage(){
        self.addSubview(userImageView);
        userImageView.leftAnchor.constraint(equalTo: self.votingView.rightAnchor, constant: 10).isActive = true;
        userImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true;
        userImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true;
        userImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true;
    }
    
    fileprivate func setupPosterNameLabel(){
        self.addSubview(posterNameLabel);
        posterNameLabel.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 5).isActive = true;
        posterNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        posterNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        posterNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -80).isActive = true;
    }
    
    fileprivate func setupCategoryNameLabel(){
        self.addSubview(categoryNameLabel);
        categoryNameLabel.leftAnchor.constraint(equalTo: self.posterNameLabel.rightAnchor, constant: 10).isActive = true;
        categoryNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        categoryNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        categoryNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupHeadlineLabel(){
        self.addSubview(headlineLabel);
        headlineLabel.leftAnchor.constraint(equalTo: self.votingView.rightAnchor, constant: 10).isActive = true;
        headlineLabel.topAnchor.constraint(equalTo: self.posterNameLabel.bottomAnchor).isActive = true;
        headlineLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        headlineLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true;
        headlineLabel.text = headlineText;
    }
    
    fileprivate func setupNumberOfPeople(){
        self.addSubview(numberOfPeopleInChatRoom);
        numberOfPeopleInChatRoom.leftAnchor.constraint(equalTo: self.votingView.rightAnchor, constant: 10).isActive = true;
        numberOfPeopleInChatRoom.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true;
        numberOfPeopleInChatRoom.topAnchor.constraint(equalTo: self.headlineLabel.bottomAnchor, constant: 5).isActive = true;
        numberOfPeopleInChatRoom.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
//        numberOfPeopleInChatRoom.backgroundColor = UIColor.red;
    }
    
    fileprivate func setupChatImage(){
        self.addSubview(chatRoomImage);
        chatRoomImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        chatRoomImage.leftAnchor.constraint(equalTo: self.numberOfPeopleInChatRoom.rightAnchor, constant: 5).isActive = true;
        chatRoomImage.topAnchor.constraint(equalTo: self.headlineLabel.bottomAnchor, constant: 5).isActive = true;
        chatRoomImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
//        chatRoomImage.backgroundColor = .blue;
    }
    
    func setPosterName(posterName: String){
        self.posterNameLabel.text = posterName;
    }
    
    func setheadline(headline: String){
        self.headlineLabel.text = headline;
    }
    
    func setCategory(categoryName: String){
        self.categoryNameLabel.text = categoryName;
    }
    
    func setVotingValue(voteValue: Int){
        self.votingView.setVoteCount(voteCount: voteValue);
    }
    
    func setHeadline(headline: Headline){
        self.cellHeadline = headline;
    }
    
    func setChatPopulation(population: Int){
        self.numberOfPeopleInChatRoom.text = "\(population)/100"
    }
    
    func setVotingStatus(){
        votingView.setVoteStatus(voteStatus: self.cellHeadline!.voteStatus!);
    }
    
}

extension FeedCollectionViewCell{
    func voted(type: Int) {
        let vote = type;
        let userID = standard.object(forKey: "userID") as! String
        let url = URL(string: "http://54.202.134.243:3000/upVote_downVote")!;
        var request = URLRequest(url: url);
        let body = "userID=\(userID)&vote=\(vote)&headlineID=\(self.cellHeadline!.headlineID!)";
        
        
        request.httpBody = body.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                DispatchQueue.main.async {
                    self.handleSendErrorNotification();
                    return;
                }
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response == "error"){
                    DispatchQueue.main.async {
                        self.handleSendErrorNotification();
                    }
                }
            }
            
        }
        task.resume();
        
    }
    
    func handleSendErrorNotification(){
//        print("error upvote/downvote");
        let name = Notification.Name(rawValue: voteSendErrorNotification);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
}
