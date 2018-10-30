//
//  PersonalInfo.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class PersonalInfoPage: UIViewController, ChangePasswordCellDelegate, PersonalInfoCellDelegate{

    var personalCollectionView: PersonalInfoCollectionView = {
        let flowLayout = UICollectionViewFlowLayout();
        var personalCollectionView = PersonalInfoCollectionView(frame: .zero, collectionViewLayout: flowLayout);
        return personalCollectionView;
    }()
    
    var startedEditing = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.veryLightGray;
        setupNavBar();
        setupCollectionView();
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(personalCollectionView);
        personalCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        personalCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        personalCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        personalCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        personalCollectionView.personalInfoPage = self;
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Personal Info";
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var count = 0;
        while(count < 4){
            let indexPath = IndexPath(item: count, section: 0);
            let cell = self.personalCollectionView.cellForItem(at: indexPath) as! PersonalInfoCell;
            cell.textField.resignFirstResponder();
            count+=1;
        }
    }
}

extension PersonalInfoPage{
    
    @objc func saveInfo(){
        //get data and save
        self.navigationController?.popViewController(animated: true);
    }
    
    func changePassword() {
        let changePasswordPage = ChangePasswordPage1();
        self.navigationController?.pushViewController(changePasswordPage, animated: true);
    }
    
    func showChangeAlert() {
        if(startedEditing == false){
            let alert = UIAlertController(title: "Change Info?", message: "Are you sure you want to change your info?", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action) in
                self.startedEditing = true;
                self.showSaveButton();
            }));
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    fileprivate func showSaveButton(){
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveInfo));
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    
    
}
