//
//  TermsAndPrivacyCell.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TermsAndPrivacyCell: UICollectionViewCell{
    
    lazy var termsTitleLabel: NormalUILabel = {
        let termsTitleLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        return termsTitleLabel;
    }()
    
    lazy var titleTextView: UITextView = {
        let titleTextView = UITextView();
        titleTextView.translatesAutoresizingMaskIntoConstraints = false;
        titleTextView.isUserInteractionEnabled = false;
        titleTextView.font = .montserratRegular(fontSize: 12);
        titleTextView.textColor = UIColor.darkGray;
        return titleTextView;
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView();
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false;
        arrowImageView.image = #imageLiteral(resourceName: "arrowToRight");
        return arrowImageView;
    }()
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = .gray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTermsTitleLabel();
        setupTitleTextView();
        setupImageView();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTermsTitleLabel(){
        self.addSubview(termsTitleLabel);
        termsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        termsTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        termsTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        termsTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupTitleTextView(){
        self.addSubview(titleTextView);
        titleTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        titleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        titleTextView.topAnchor.constraint(equalTo: termsTitleLabel.bottomAnchor).isActive = true;
        titleTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    fileprivate func setupImageView(){
        self.addSubview(arrowImageView);
        arrowImageView.leftAnchor.constraint(equalTo: self.termsTitleLabel.rightAnchor, constant: 5).isActive = true;
        arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        arrowImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true;
    }
    
    func setData(cellTitle: String, cellDescription: String){
        self.termsTitleLabel.text = cellTitle;
        self.titleTextView.text = cellDescription;
    }
    
    func hideBorder(){
        self.border.isHidden = true;
    }
}
