//
//  GlobalFeed.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class GlobalFeed: UIViewController{
    
    lazy var globalFeed: FeedCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let globalFeed = FeedCollectionView(frame: .zero, collectionViewLayout: layout);
        return globalFeed;
    }()
    
    //collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupGlobalFeed();
    }
    
    fileprivate func setupGlobalFeed(){
        self.view.addSubview(globalFeed);
        globalFeed.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        globalFeed.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        globalFeed.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        globalFeed.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
}
