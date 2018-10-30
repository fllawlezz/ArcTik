//
//  ProfileCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ProfileCollectionViewDelegate{
    func handleToPeresonalInfoPage();
    func handleToTermsAndPrivacyPage();
    func handleLogout();
}

class ProfileCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var profileCollectionViewDelegate: ProfileCollectionViewDelegate?;
    
    let reuseHeader = "regularHeader";
    let reuseAccountOverview = "accountOverview";
    let reuseNormalProfileCell = "profileCell";
    let reuseLogout = "logout";
    
    var cellTitles = [String]();
    let cellDescriptions = ["Change your profile info","View Terms and Privacy Policy","Notifications"];
    var userName: String?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        getData();
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.veryLightGray;
        self.register(AccountOverviewCell.self, forCellWithReuseIdentifier: reuseAccountOverview);
        self.register(RegularHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeader);
        self.register(NormalProfileCell.self, forCellWithReuseIdentifier: reuseNormalProfileCell);
        self.register(LogoutCell.self, forCellWithReuseIdentifier: reuseLogout);
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func getData(){
        self.userName = (standard.object(forKey: "userName") as! String);
        let firstName = standard.object(forKey: "firstName") as! String;
        let lastName = standard.object(forKey: "lastName") as! String;
        let fullName = "\(firstName) \(lastName)"
        cellTitles.append(fullName);
        cellTitles.append("Terms and privacy");
        cellTitles.append("Notifications");
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseAccountOverview, for: indexPath) as! AccountOverviewCell
            cell.setUserName(username: self.userName!);
            cell.setFollowers(followers: 20);
            return cell;
        }else if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseNormalProfileCell, for: indexPath) as! NormalProfileCell;
            cell.setTitle(title: cellTitles[indexPath.item]);
            cell.setDescription(description: cellDescriptions[indexPath.item]);
            if(indexPath.item+1 == cellDescriptions.count){
                cell.hideBorder();
            }
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseLogout, for: indexPath) as! LogoutCell
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1;
        }else if(section == 1){
            return 3;
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: UIscreenWidth!, height: 70);
        }else{
            return CGSize(width: UIscreenWidth!, height: 70);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(section == 0){
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0);
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            if(indexPath.item == 0){
                self.profileCollectionViewDelegate?.handleToPeresonalInfoPage();
            }else if(indexPath.item == 1){
                self.profileCollectionViewDelegate?.handleToTermsAndPrivacyPage()
            }else if(indexPath.item == 2){
                
            }else if(indexPath.item == 3){
                
            }
        }else if(indexPath.section == 2){
            self.profileCollectionViewDelegate?.handleLogout();
        }
    }
}
