//
//  PrivacyPage.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class PrivacyPage: UIViewController{
    
    lazy var privacyView: UIWebView = {
        let privacyView = UIWebView();
        privacyView.translatesAutoresizingMaskIntoConstraints = false;
        return privacyView;
    }()
    
    let urlString = "https://www.google.com";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupPrivacyView();
        
        let url = URL(string: urlString)!;
        privacyView.loadRequest(URLRequest(url: url));
    }
    
    fileprivate func setupPrivacyView(){
        self.view.addSubview(privacyView);
        privacyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        privacyView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        privacyView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        if #available(iOS 11.0, *) {
            privacyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            privacyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        };
        
    }
    
}

