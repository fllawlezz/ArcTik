//
//  TermsAndPrivacyPage.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TermsAndPrivacyPage: UIViewController{
    
    lazy var termsCollectionView: TermsCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let termsCollectionView = TermsCollectionView(frame: .zero, collectionViewLayout: layout);
        return termsCollectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupCollectionView();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Terms and Privacy";
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(termsCollectionView);
        termsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        termsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        termsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        termsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        termsCollectionView.termsAndPrivacyPage = self;
    }
}
