//
//  NewHeadlineView.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NewHeadlineView: UIView, UITextViewDelegate {
    
    lazy var titleView: NormalUILabel = {
        let titleView = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 18), textAlign: .center);
        titleView.text = "Headline";
        return titleView;
    }()
    
    lazy var headlineTextView: HeadlineTextView = {
        let headlineTextView = HeadlineTextView();
        headlineTextView.returnKeyType = .done;
        return headlineTextView;
    }()
    
    lazy var characterCountLabel: NormalUILabel = {
        let characterCountLabel = NormalUILabel(textColor: UIColor.black, font: .montserratSemiBold(fontSize: 12), textAlign: .right);
        characterCountLabel.text = "0/150";
        return characterCountLabel;
    }()
    
    var characterCount = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        setupTitleView();
        setupHeadlineTextView();
        setupCharacterCount();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleView(){
        self.addSubview(titleView);
        titleView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        titleView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupHeadlineTextView(){
        self.addSubview(headlineTextView);
        headlineTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        headlineTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        headlineTextView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10).isActive = true;
        headlineTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -35).isActive = true;
        headlineTextView.delegate = self;
    }
    
    fileprivate func setupCharacterCount(){
        self.addSubview(characterCountLabel);
        characterCountLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        characterCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        characterCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        characterCountLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.headlineTextView.resignFirstResponder();
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder();
            return false;
        }
        return true;
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(textView.text.count > 0){
            if(textView.text.count > 150){
                let newText = textView.text.dropLast();
                textView.text = String(newText);
            }
            
            if(textView.text.count == 150){
                self.characterCountLabel.textColor = UIColor.red;
            }else{
                self.characterCountLabel.textColor = UIColor.black;
            }
            self.characterCount = textView.text.count;
            self.characterCountLabel.text = "\(self.characterCount)/150";
        }
    }
    
}
