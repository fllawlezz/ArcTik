//
//  NormalProfileCell.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NormalProfileCell: UICollectionViewCell{
    
    lazy var profileCellMainTitleLabel: NormalUILabel = {
        let profileCellMainTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
//        profileCellMainTitleLabel.backgroundColor = UIColor.blue;
        return profileCellMainTitleLabel;
    }()
    
    lazy var profileDescriptionTextView: UITextView = {
        let profileDescriptionTextView = UITextView();
        profileDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        profileDescriptionTextView.isEditable = false;
        profileDescriptionTextView.isScrollEnabled = false;
        profileDescriptionTextView.textColor = UIColor.darkGray;
        profileDescriptionTextView.font = UIFont.montserratRegular(fontSize: 12);
        profileDescriptionTextView.isUserInteractionEnabled = false;
//        profileDescriptionTextView.backgroundColor = UIColor.red;
        return profileDescriptionTextView;
    }()
    
    lazy var arrowToRightImageView: UIImageView = {
        let arrowToRightImageView = UIImageView();
        arrowToRightImageView.translatesAutoresizingMaskIntoConstraints = false;
        arrowToRightImageView.image = #imageLiteral(resourceName: "arrowToRight");
//        arrowToRightImageView.backgroundColor = UIColor.red;
        return arrowToRightImageView;
    }()
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupMainTitle();
        setupDescription();
        setupArrowToRightImage();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupMainTitle(){
        self.addSubview(profileCellMainTitleLabel);
        profileCellMainTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true;
        profileCellMainTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true;
        profileCellMainTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        profileCellMainTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
    }
    
    fileprivate func setupDescription(){
        self.addSubview(profileDescriptionTextView);
        profileDescriptionTextView.leftAnchor.constraint(equalTo: self.profileCellMainTitleLabel.leftAnchor, constant: -5).isActive = true;
        profileDescriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true;
        profileDescriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        profileDescriptionTextView.topAnchor.constraint(equalTo: self.profileCellMainTitleLabel.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupArrowToRightImage(){
        self.addSubview(arrowToRightImageView);
        arrowToRightImageView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true;
        arrowToRightImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        arrowToRightImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true;
        arrowToRightImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    func setTitle(title: String){
        self.profileCellMainTitleLabel.text = title;
    }
    
    func setDescription(description: String){
        self.profileDescriptionTextView.text = description;
    }
    
    func hideBorder(){
        self.border.isHidden = true;
    }
    
}
