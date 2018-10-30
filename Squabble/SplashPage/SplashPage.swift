//
//  SplashPage.swift
//  Squabble
//
//  Created by Brandon In on 10/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class SplashPage: UIViewController{
    
    var squabbleImage: UIImageView = {
        let squabbleImage = UIImageView();
        squabbleImage.image = UIImage(named: "BasicLogo");
        squabbleImage.translatesAutoresizingMaskIntoConstraints = false;
        return squabbleImage;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupSquabbleImage();
        
        _  = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.stopRotation), userInfo: nil, repeats: false);
//        let timer = Timer(timeInterval: 5, target: self, selector: #selector(self.stopRotation), userInfo: nil, repeats: false);
        rotateImage();
    }
    
    fileprivate func setupSquabbleImage(){
        self.view.addSubview(squabbleImage);
        squabbleImage.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        squabbleImage.heightAnchor.constraint(equalToConstant: 220).isActive = true;
        squabbleImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        squabbleImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
    }
    
    @objc func rotateImage(){
        UIView.animate(withDuration: 0.3) {
            self.rotateView(view: self.squabbleImage);
//            self.rotateImage();
        }
    }
    
    @objc fileprivate func stopRotation(){
        stopRotatingView(view: self.squabbleImage);
        UIView.animate(withDuration: 0.3) {
            self.squabbleImage.frame.origin.y += 100;
        }
        let customTabBar = CustomTabBarController();
        self.present(customTabBar, animated: true, completion: nil);
    }
    
    let kRotationAnimationKey = "rotationKey";
    
}

extension SplashPage{
    
    func rotateView(view: UIView, duration: Double = 1) {
        if view.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(Double.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
    func stopRotatingView(view: UIView) {
        if view.layer.animation(forKey: kRotationAnimationKey) != nil {
            view.layer.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
}
