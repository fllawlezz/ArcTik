//
//  TermsCollectionView.swift
//  Squabble
//
//  Created by Brandon In on 8/9/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TermsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var termsAndPrivacyPage: TermsAndPrivacyPage?
    
    var reuseTermsAndPrivacy = "termsAndPrivacy";
    
    let cellTitles = ["Terms And Conditions","Privacy Agreement"];
    let cellDescription = ["Read the terms and conditions you agree to","Read the privacy terms you agree to"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.backgroundColor = UIColor.veryLightGray;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.register(TermsAndPrivacyCell.self, forCellWithReuseIdentifier: reuseTermsAndPrivacy);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseTermsAndPrivacy, for: indexPath) as! TermsAndPrivacyCell
        cell.setData(cellTitle: cellTitles[indexPath.item], cellDescription: cellDescription[indexPath.item]);
        if(indexPath.item+1 == cellTitles.count){
            cell.hideBorder();
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.item == 0){
            let termsPage = TermsPage();
            termsPage.hidesBottomBarWhenPushed = true;
            termsAndPrivacyPage?.navigationController?.pushViewController(termsPage, animated: true);
        }else if(indexPath.item == 1){
            let privacyPage = PrivacyPage();
            privacyPage.hidesBottomBarWhenPushed = true;
            termsAndPrivacyPage?.navigationController?.pushViewController(privacyPage, animated: true);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 70);
    }
    
}
