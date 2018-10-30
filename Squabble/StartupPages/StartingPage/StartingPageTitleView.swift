//
//  StartingPageTitleView.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class StartingPageTitleView: UIView{
    
    lazy var mainTitleLabel: NormalUILabel = {
        let mainTitleLabel = NormalUILabel(textColor: .white, font: .montserratBold(fontSize: 35), textAlign: .right);
        mainTitleLabel.text = "Squabble";
        return mainTitleLabel;
    }()
    
    lazy var penguinImage: UIImageView = {
        let penguinImage = UIImageView();
        penguinImage.translatesAutoresizingMaskIntoConstraints = false;
        penguinImage.image = #imageLiteral(resourceName: "BasicLogo");
        return penguinImage;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .clear;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupMainTitleView();
        setupImageView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupMainTitleView(){
        self.addSubview(mainTitleLabel);
        mainTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true;
        mainTitleLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: 50).isActive = true;
        mainTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        mainTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupImageView(){
        self.addSubview(penguinImage);
//        penguinImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        penguinImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        penguinImage.leftAnchor.constraint(equalTo: self.mainTitleLabel.rightAnchor, constant: 5).isActive = true;
        penguinImage.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        penguinImage.widthAnchor.constraint(equalToConstant: 70).isActive = true;
    }
    
}
