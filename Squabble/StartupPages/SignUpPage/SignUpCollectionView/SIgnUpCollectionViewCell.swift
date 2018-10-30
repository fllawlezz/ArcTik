//
//  SIgnUpCollectionViewCell.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol SignUpCollectionViewCellDelegate{
    func nextTextField(cellIndex: Int);
}

class SignUpCollectionViewCell: UICollectionViewCell, UITextFieldDelegate{
    
    var delegate: SignUpCollectionViewCellDelegate?
    
    lazy var inputTextField: NormalUITextField = {
        let inputTextField = NormalUITextField();
        inputTextField.translatesAutoresizingMaskIntoConstraints = false;
        inputTextField.textColor = UIColor.white;
        inputTextField.font = UIFont.systemFont(ofSize: 14);
        inputTextField.textAlignment = .left;
        inputTextField.backgroundColor = UIColor.lightAppBlue;
        inputTextField.autocorrectionType = .no;
        inputTextField.spellCheckingType = .no;
        inputTextField.returnKeyType = .next;
        return inputTextField;
    }()
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = #imageLiteral(resourceName: "BlueX");
        imageView.contentMode = .scaleAspectFit
        return imageView;
    }()
    
    var placeholderString: String?;
    var cellIndex: Int? //when inputTextField return, go to the next field if applicable
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
        setupInputTextField();
        setupBorder();
//        setupImage();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupInputTextField(){
        self.addSubview(inputTextField);
        inputTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        inputTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        inputTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        inputTextField.delegate = self;
        inputTextField.addTarget(self, action: #selector(selectedTextField), for: .editingDidBegin);
//        inputTextField.addTarget(self, action: #selector(deselectedTextField), for: .)
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    fileprivate func setupImage(){
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20));
        containerView.addSubview(imageView);
        
        inputTextField.rightViewMode = .always;
        inputTextField.rightView = containerView;
        
    }
    
    func setData(title: String, placeholderString: String){
        
        self.placeholderString = placeholderString;
        
        let attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.white])
        self.inputTextField.attributedPlaceholder = attributedPlaceholder;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.placeholder == "Password"){
            if(UIscreenWidth == 320){
                NotificationCenter.default.post(name: keyboardDownNotification, object: nil);
            }
            self.inputTextField.resignFirstResponder();
            //try to and sign up
            return true;
        }
        
        if let cellIndex = self.cellIndex{
            delegate?.nextTextField(cellIndex: cellIndex);
        }
        return true;
    }
    
}

extension SignUpCollectionViewCell{
    @objc func selectedTextField(){
        if(self.inputTextField.placeholder! == "Password"){
            if(UIscreenWidth == 320){
                NotificationCenter.default.post(name: keyboardUpNotification, object: nil);
            }
        }else{
            NotificationCenter.default.post(name: keyboardDownNotification, object: nil);
        }
    }
}
