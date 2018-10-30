//
//  RegularHeaderCell.swift
//  Squabble
//
//  Created by Brandon In on 7/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class RegularHeaderCell: UICollectionReusableView{
    
    lazy var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 16), textAlign: .left);
        return titleLabel;
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
        setupTitleLabel();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    func setTitle(titleString: String){
        self.titleLabel.text = titleString;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    
    
    
}
