//
//  NewHeadlineTitleView.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//protocol
protocol NewHeadLineTitleViewDelegate {
    func didCancel();
}

class NewHeadlineTitleView: UIView{
    
    var delegate: NewHeadLineTitleViewDelegate?
    
    lazy var backgroundColorView: UIView = {
        let backgroundColorView = UIView();
        backgroundColorView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundColorView.backgroundColor = UIColor.appBlue;
        return backgroundColorView;
    }()
    
    lazy var titleView: NormalUILabel = {
        let titleView = NormalUILabel(textColor: UIColor.white, font: UIFont.montserratSemiBold(fontSize: 20), textAlign: .center);
        titleView.text = "New Headline";
        return titleView;
    }()
    
    lazy var clearButton: NormalUIButton = {
        let clearButton = NormalUIButton(backgroundColor: UIColor.clear, title: "", font: UIFont.montserratBold(fontSize: 15), fontColor: UIColor.black);
        clearButton.setBackgroundImage(#imageLiteral(resourceName: "whiteClear"), for: .normal);
        clearButton.tintColor = UIColor.white;
        
        return clearButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupTitleBackground();
        setupTitleView();
        setupClearButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleBackground(){
        self.addSubview(backgroundColorView);
        backgroundColorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        backgroundColorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
//        backgroundColorView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupTitleView(){
        self.addSubview(titleView);
        titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        titleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupClearButton(){
        self.addSubview(clearButton);
        clearButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
//        clearButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        clearButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        clearButton.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        clearButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        clearButton.addTarget(self, action: #selector(handleClear), for: .touchUpInside);
    }
    
    @objc func handleClear(){
        delegate?.didCancel();
    }
    
}
