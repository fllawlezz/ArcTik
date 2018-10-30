//
//  TermsPage.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TermsPage: UIViewController{
    
    lazy var termsView: UIWebView = {
        let termsView = UIWebView();
        termsView.translatesAutoresizingMaskIntoConstraints = false;
        return termsView;
    }()
    
    let urlString = "https://www.google.com";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupTermsView();
        
        let url = URL(string: urlString)!;
        termsView.loadRequest(URLRequest(url: url));
    }
    
    fileprivate func setupTermsView(){
        self.view.addSubview(termsView);
        termsView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        termsView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        termsView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        if #available(iOS 11.0, *) {
            termsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            termsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        };
//        termsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
}
