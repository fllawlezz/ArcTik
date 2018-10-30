//
//  PersonalInfoCell.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol PersonalInfoCellDelegate{
    func showChangeAlert();
}

class PersonalInfoCell: UICollectionViewCell, UITextFieldDelegate{
    
    var titleData: String?
    var textFieldData: String?
    
    var personalInfoCellDelegate: PersonalInfoCellDelegate?;
    
    var titleLabel: NormalUILabel = {
        var titleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratBold(fontSize: 14), textAlign: .left);
        return titleLabel;
    }()
    
    var textField: NormalUITextField = {
        var textField = NormalUITextField();
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.font = UIFont.montserratSemiBold(fontSize: 14);
        textField.placeholder = "This placeHolder";
        return textField;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
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
    
    func setData(titleData: String, textFieldData: String){
        self.titleData = titleData;
        self.textFieldData = textFieldData;
        self.titleLabel.text = "\(titleData):"
        textField.text = textFieldData;
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
    }
    
    fileprivate func setupTextField(){
        self.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 5).isActive = true;
        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        textField.delegate = self;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    func hideBorder(){
        self.border.isHidden = true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        personalInfoCellDelegate?.showChangeAlert();
    }
    
}
