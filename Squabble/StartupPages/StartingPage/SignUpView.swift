//
//  SignUpView.swift
//  Squabble
//
//  Created by Brandon In on 8/10/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//
import Foundation
import UIKit

protocol SignUpViewDelegate{
    func handleSignUp();
}

class SignUpView: UIView, UITextViewDelegate {
    
    var delegate: SignUpViewDelegate?
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.white;
        return border;
    }()
    
    lazy var signUpTextView: UITextView = {
        let signUpTextView = UITextView();
        signUpTextView.translatesAutoresizingMaskIntoConstraints = false;
        signUpTextView.textAlignment = .center;
        signUpTextView.isEditable = false;
        signUpTextView.isScrollEnabled = false;
        signUpTextView.textColor = UIColor.white;
        signUpTextView.backgroundColor = UIColor.clear;
        signUpTextView.font = UIFont.systemFont(ofSize: 14);
        signUpTextView.text = "Hello World this is your manager speaking"
        return signUpTextView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupBorder();
        setupSignUpTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    fileprivate func setupSignUpTextView(){
        self.addSubview(signUpTextView);
        signUpTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        signUpTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        signUpTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        signUpTextView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        signUpTextView.delegate = self;
        
        let originalText = "Don't have an account? Sign Up";
        let attributedText = NSMutableAttributedString(string: originalText);
        let centerAlignment = NSMutableParagraphStyle();
        centerAlignment.alignment = .center;
        let linkRange = attributedText.mutableString.range(of: "Sign Up");
        attributedText.addAttribute(.link, value: "nextController", range: linkRange);
        attributedText.addAttribute(.paragraphStyle, value: centerAlignment, range: NSMakeRange(0, attributedText.length));
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedText.length));
        attributedText.addAttribute(.font, value: UIFont.montserratRegular(fontSize: 14), range: NSMakeRange(0, attributedText.length));
        
        signUpTextView.attributedText = attributedText;
        signUpTextView.linkTextAttributes = [NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue];
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.delegate?.handleSignUp();
        return false;
    }
}
