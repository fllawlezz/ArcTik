//
//  Profile.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ProfilePage: UIViewController, ProfileCollectionViewDelegate{
    
    lazy var profileCollectionView: ProfileCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let profileCollectionView = ProfileCollectionView(frame: .zero, collectionViewLayout: layout);
        return profileCollectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupProfileCollectionView();
    }
    
    fileprivate func setupProfileCollectionView(){
        self.view.addSubview(profileCollectionView);
        profileCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        profileCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        profileCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        profileCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        profileCollectionView.profileCollectionViewDelegate = self;
    }
    
}

extension ProfilePage{
    func handleToPeresonalInfoPage() {
        let personalInfoPage = PersonalInfoPage();
        personalInfoPage.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(personalInfoPage, animated: true);

    }
    
    func handleToTermsAndPrivacyPage() {
        let termsPage = TermsAndPrivacyPage();
        termsPage.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(termsPage, animated: true);
    }
    
    func handleLogout(){
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            removeStandards();
            let startingPage = StartingPage();
            let navigationController = UINavigationController(rootViewController: startingPage);
            navigationController.navigationBar.isHidden = true;
            self.present(navigationController, animated: true, completion: nil);
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        

    }
    
}
