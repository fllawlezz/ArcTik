//
//  SignUpBottomView.swift
//  Squabble
//
//  Created by Brandon In on 8/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol SignUpBottomViewDelegate{
    func handleSubmit();
}

class SignUpBottomView: UIView, UITextViewDelegate{
    
    let termsLink = "https://google.com";
    let privacyLink = "https://google.com";
    
    var bottomViewDelegate: SignUpBottomViewDelegate?;
    
    lazy var signUpButton: NormalUIButton = {
        let signUpButton = NormalUIButton(backgroundColor: .clear, title: "Sign Up", font: .montserratSemiBold(fontSize: 18), fontColor: .white);
        signUpButton.layer.cornerRadius = 0;
        signUpButton.layer.borderColor = UIColor.white.cgColor;
        signUpButton.layer.borderWidth = 1;
        return signUpButton;
    }()
    
    lazy var termsTextView: UITextViewNoResponder = {
        let termsTextView = UITextViewNoResponder();
        termsTextView.translatesAutoresizingMaskIntoConstraints = false;
        termsTextView.textAlignment = .center;
        termsTextView.isEditable = false;
//        termsTextView.isUserInteractionEnabled = false;
        termsTextView.isScrollEnabled = false;
        termsTextView.textColor = UIColor.gray;
        termsTextView.font = UIFont.systemFont(ofSize: 12);
        termsTextView.backgroundColor = .clear;
        return termsTextView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .clear;
//        self.backgroundColor = .red;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupSignUpButton();
        setupTermsTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupSignUpButton(){
        self.addSubview(signUpButton);
        signUpButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        signUpButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        signUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        signUpButton.addTarget(self, action: #selector(self.handleSubmit), for: .touchUpInside);
    }
    
    fileprivate func setupTermsTextView(){
        self.addSubview(termsTextView);
        termsTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        termsTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        termsTextView.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 10).isActive = true;
        termsTextView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        termsTextView.delegate = self;
        
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.touchedTextView));
//        termsTextView.addGestureRecognizer(gestureRecognizer);

        let originalText = "By Signing Up, you agree to our Terms and Privacy Policy";
        let attributedOriginalText = NSMutableAttributedString(string: originalText);
        let centerAlignment = NSMutableParagraphStyle();
        centerAlignment.alignment = .center;
        let termsLinkRange = attributedOriginalText.mutableString.range(of: "Terms");
        let privacyLinkRange = attributedOriginalText.mutableString.range(of: "Privacy Policy");
        attributedOriginalText.addAttribute(.link, value: termsLink, range: termsLinkRange);
        attributedOriginalText.addAttribute(.link, value: privacyLink, range: privacyLinkRange);
        attributedOriginalText.addAttribute(.paragraphStyle, value: centerAlignment, range: NSMakeRange(0, attributedOriginalText.length));
        attributedOriginalText.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedOriginalText.length));
        attributedOriginalText.addAttribute(.font, value: UIFont.systemFont(ofSize: 10), range: NSMakeRange(0, attributedOriginalText.length));

        self.termsTextView.attributedText = attributedOriginalText;
        self.termsTextView.linkTextAttributes = [NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue];
    }
}

extension SignUpBottomView{
    
//    @objc func touchedTextView(){
//        print("touched");
//    }
    
    @objc func handleSubmit(){
        self.bottomViewDelegate?.handleSubmit();
    }
    
}
