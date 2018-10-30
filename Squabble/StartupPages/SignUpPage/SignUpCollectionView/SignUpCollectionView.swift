//
//  SignUpCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SignUpCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SignUpCollectionViewCellDelegate{
    
    let reuseField = "reuseField";
    let cellTitles = ["UserName","FirstName","LastName","Email","Password"];
    
    var signUpPage: SignUpPage?
    
    var userName: String?;
    var firstName: String?;
    var lastName: String?;
    var email: String?;
    var password: String?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.clear;
        self.register(SignUpCollectionViewCell.self, forCellWithReuseIdentifier: reuseField);
        self.delegate = self;
        self.dataSource = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func resignAll(){
        var count = 0;
        while(count < 5){
            let indexPath = IndexPath(item: count, section: 0);
            let cell = self.cellForItem(at: indexPath) as! SignUpCollectionViewCell;
            cell.inputTextField.resignFirstResponder();
            count+=1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseField, for: indexPath) as! SignUpCollectionViewCell
        cell.setData(title: cellTitles[indexPath.item], placeholderString: cellTitles[indexPath.item]);
        cell.cellIndex = indexPath.item;
        cell.delegate = self;
        if(indexPath.item == 3){
            cell.inputTextField.keyboardType = .emailAddress;
            
        }else if(indexPath.item == 4){
            cell.inputTextField.isSecureTextEntry = true;
            cell.inputTextField.returnKeyType = .done;
        }
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
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
}

extension SignUpCollectionView{
    func nextTextField(cellIndex: Int) {
        print(cellIndex);
        if(cellIndex < 4){
            let nextCellIndex = cellIndex+1;
            let newIndexPath = IndexPath(item: nextCellIndex, section: 0);
            let nextCell = self.cellForItem(at: newIndexPath) as! SignUpCollectionViewCell;
            nextCell.inputTextField.becomeFirstResponder();
        }
    }
    
    func getAllFieldData(){
        var count = 0;
        while(count < cellTitles.count){
            let cell = self.cellForItem(at: IndexPath(item: count, section: 0)) as! SignUpCollectionViewCell;
            switch(count){
            case 0: self.userName = cell.inputTextField.text;break;
            case 1: self.firstName = cell.inputTextField.text;break;
            case 2: self.lastName = cell.inputTextField.text;break;
            case 3: self.email = cell.inputTextField.text;break;
            case 4: self.password = cell.inputTextField.text;break;
            default: break;
            }
            
            count += 1;
        }
        
        signUpPage?.userName = self.userName;
        signUpPage?.firstName = self.firstName;
        signUpPage?.lastName = self.lastName;
        signUpPage?.email = self.email;
        signUpPage?.password = self.password;
    }
}
