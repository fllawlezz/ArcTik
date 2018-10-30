//
//  ChangePasswordPage2.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ChangePasswordPage2: UIViewController, ChangePasswordCollectionViewDelegate{
    
    lazy var changePasswordCollectionView: ChangePasswordCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let changePasswordCollectionView = ChangePasswordCollectionView(frame: .zero, collectionViewLayout: layout);
        return changePasswordCollectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupChangePasswordCollectionView();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "New Password";
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel));
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save));
        
        self.navigationItem.hidesBackButton = true;
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    
    fileprivate func setupChangePasswordCollectionView(){
        self.view.addSubview(changePasswordCollectionView);
        changePasswordCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        changePasswordCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        changePasswordCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        changePasswordCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        changePasswordCollectionView.changePasswordDelegate = self;
    }
    
}

extension ChangePasswordPage2{
    @objc func handleCancel(){
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true);
    }
    
    @objc func save(){
        //save newPassword
        handleCancel();
    }
    
    //delegate method
    func savePassword(newPassword: String){
        //save new password
        handleCancel();
    }
}

protocol ChangePasswordCollectionViewDelegate{
    func savePassword(newPassword: String);
}

class ChangePasswordCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ChangePasswordCollectionViewCellDelegate{
    
    var changePasswordDelegate: ChangePasswordCollectionViewDelegate?;
    
    let reuseOne = "reuseOne";
    let cellTitles = ["New Password:","Repeat:"];
    let cellPlaceholders = ["New Password", "Repeat Password"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = .veryLightGray;
        self.dataSource = self;
        self.delegate = self;
        self.register(ChangePasswordCollectionViewCell.self, forCellWithReuseIdentifier: reuseOne);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! ChangePasswordCollectionViewCell
        cell.setData(title: cellTitles[indexPath.item], placeHolder: cellPlaceholders[indexPath.item]);
        cell.delegate = self;
        cell.cellIndex = indexPath.item;
        if(indexPath.item == 1){
            cell.currentTextField.returnKeyType = .go;
            cell.hideBorder();
        }else{
            cell.currentTextField.returnKeyType = .next;
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 60);
    }
    
    func nextTextField(cellIndex: Int){
        let newIndex = cellIndex + 1;
        let cell = self.cellForItem(at: IndexPath(item: newIndex, section: 0)) as! ChangePasswordCollectionViewCell;
        cell.currentTextField.becomeFirstResponder();
    }
    
    func savePassword(newPassword: String){
        changePasswordDelegate?.savePassword(newPassword: newPassword);
    }
}

protocol ChangePasswordCollectionViewCellDelegate{
    func nextTextField(cellIndex: Int);
    func savePassword(newPassword: String);
}

class ChangePasswordCollectionViewCell: UICollectionViewCell, UITextFieldDelegate{
    
    var delegate: ChangePasswordCollectionViewCellDelegate?
    
    lazy var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 16), textAlign: .left);
        return titleLabel;
    }()
    
    lazy var currentTextField: NormalUITextField = {
        let currentTextField = NormalUITextField();
        currentTextField.translatesAutoresizingMaskIntoConstraints = false;
        currentTextField.font = .systemFont(ofSize: 16);
        currentTextField.textColor = .black;
        currentTextField.placeholder = "New Password";
        currentTextField.textAlignment = .left;
        currentTextField.isSecureTextEntry = true;
        return currentTextField;
    }()
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    var cellIndex: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupTextField();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 125).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupTextField(){
        self.addSubview(currentTextField);
        currentTextField.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true;
        currentTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        currentTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        currentTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        currentTextField.delegate = self;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    func setData(title: String, placeHolder: String){
        self.titleLabel.text = title;
        self.currentTextField.placeholder = placeHolder;
    }
    
    func hideBorder(){
        self.border.isHidden = true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        if(self.cellIndex! == 0){
            //to repeat
            delegate?.nextTextField(cellIndex: self.cellIndex!)
        }else{
            //save
            print("save");
            delegate?.savePassword(newPassword: self.currentTextField.text!);
        }
        return true;
    }
    
}
