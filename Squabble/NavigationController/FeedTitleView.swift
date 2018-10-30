//
//  LocalFeedTitleView.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class FeedTitleView: UISegmentedControl{
    
    override init(items: [Any]?) {
        super.init(items: items);
        setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.selectedSegmentIndex = 0;
        self.tintColor = UIColor.white;
        self.setWidth(70, forSegmentAt: 0);
        self.setWidth(70, forSegmentAt: 1);
    }
    
    fileprivate func switchSegments(){
        let selectedIndex = self.selectedSegmentIndex;
        if(selectedIndex == 0){
            //refresh collectionView
        }else if(selectedIndex == 1){
            //switch sections
            //reload collectionview
        }
    }
    
    
    
}
