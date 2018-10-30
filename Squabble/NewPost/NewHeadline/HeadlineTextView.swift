//
//  HeadlineTextview.swift
//  Squabble
//
//  Created by Brandon In on 7/31/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class HeadlineTextView: UITextView{
    
    lazy var placeholderLabel: UILabel = {
        let placeholder = UILabel();
        placeholder.translatesAutoresizingMaskIntoConstraints = false;
        placeholder.text = "New Headline";
        placeholder.textColor = UIColor.lightGray;
        return placeholder;
    }()
    
    func showPlaceholder(){
        self.placeholderLabel.isHidden = false;
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer);
//        self.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.font = UIFont.systemFont(ofSize: 14);
        self.textColor = UIColor.black;
        self.layer.cornerRadius = 10;
        self.layer.borderColor = UIColor.lightGray.cgColor;
        self.layer.borderWidth = 1;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextChanged), name: .UITextViewTextDidChange, object: nil);
        
        self.addSubview(placeholderLabel);
        placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        placeholderLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        placeholderLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    @objc func handleTextChanged(){
        self.placeholderLabel.isHidden = !self.text.isEmpty;
    }
    
    
}
