//
//  PersonalInfoCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class PersonalInfoCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var personalInfoPage: PersonalInfoPage?
    
    let personalInfoReuse = "personalInfo";
    let passwordReuse = "password";
    
    let textFieldTitles = ["UserName","FirstName","LastName","Email"];
//    let textFieldData = ["Fllawlezz","Brandon","In","fllawlezz@gmail.com"];
    var textFieldData = [String]();
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        getTextFieldData();
        self.backgroundColor = UIColor.clear;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.register(PersonalInfoCell.self, forCellWithReuseIdentifier: personalInfoReuse);
        self.register(ChangePasswordCell.self, forCellWithReuseIdentifier: passwordReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func getTextFieldData(){
        let userName = standard.object(forKey: "userName") as! String;
        let firstName = standard.object(forKey: "firstName") as! String;
        let lastName = standard.object(forKey: "lastName") as! String;
        let email = standard.object(forKey: "email") as! String;
        textFieldData.append(userName);
        textFieldData.append(firstName);
        textFieldData.append(lastName);
        textFieldData.append(email);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalInfoReuse, for: indexPath) as! PersonalInfoCell;
            cell.personalInfoCellDelegate = self.personalInfoPage;
            cell.setData(titleData: self.textFieldTitles[indexPath.item], textFieldData: textFieldData[indexPath.item]);
            if(indexPath.item+1 == self.textFieldTitles.count){
                cell.hideBorder();
            }
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: passwordReuse, for: indexPath) as! ChangePasswordCell;
            cell.delegate = self.personalInfoPage;
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 4;
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var count = 0;
        while(count < 4){
            let indexPath = IndexPath(item: count, section: 0);
            let cell = self.cellForItem(at: indexPath) as! PersonalInfoCell;
            cell.textField.resignFirstResponder();
            count+=1;
        }
    }
}
