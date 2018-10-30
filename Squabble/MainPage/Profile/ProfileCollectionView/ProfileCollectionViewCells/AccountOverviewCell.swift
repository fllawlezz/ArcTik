//
//  AccountOverviewCell.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class AccountOverviewCell: UICollectionViewCell{
    
    lazy var usernameLabel: NormalUILabel = {
        let usernameLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 20), textAlign: .left);
        return usernameLabel;
    }()
    
    lazy var numberOfFollowersLabel: NormalUILabel = {
        let numberOfFollowersLabel = NormalUILabel(textColor: UIColor.appBlue, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        return numberOfFollowersLabel;
    }()
    
    lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView();
        profileImageView.translatesAutoresizingMaskIntoConstraints = false;
        profileImageView.image = #imageLiteral(resourceName: "bone");
        return profileImageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        setupImageView();
        setupUsernameLabel();
        setupNumberOfFollowersLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupImageView(){
        self.addSubview(profileImageView);
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        profileImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        profileImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupUsernameLabel(){
        self.addSubview(usernameLabel);
        usernameLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 10).isActive = true;
        usernameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        usernameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupNumberOfFollowersLabel(){
        self.addSubview(numberOfFollowersLabel);
        numberOfFollowersLabel.leftAnchor.constraint(equalTo: self.usernameLabel.leftAnchor).isActive = true;
        numberOfFollowersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        numberOfFollowersLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: -5).isActive = true;
        numberOfFollowersLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    func setUserName(username: String){
        self.usernameLabel.text = username;
    }
    
    func setFollowers(followers: Int){
        self.numberOfFollowersLabel.text = "\(followers) Followers"
    }
    
}
