//
//  SplashPage.swift
//  Squabble
//
//  Created by Brandon In on 10/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class SplashPage: UIViewController, CLLocationManagerDelegate{
    
    var squabbleImage: UIImageView = {
        let squabbleImage = UIImageView();
        squabbleImage.image = UIImage(named: "BasicLogo");
        squabbleImage.translatesAutoresizingMaskIntoConstraints = false;
        return squabbleImage;
    }()
    
    var locationManager: CLLocationManager!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupSquabbleImage();
        
//        _  = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.stopRotation), userInfo: nil, repeats: false);
//        let timer = Timer(timeInterval: 5, target: self, selector: #selector(self.stopRotation), userInfo: nil, repeats: false);
        rotateImage();
        handleGetLocation();
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


extension SplashPage{
    func handleGetLocation(){
        self.locationManager = CLLocationManager();
        locationManager.requestWhenInUseAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.requestLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation();
        self.locationManager.delegate = nil;
        let locValue:CLLocationCoordinate2D = (locationManager.location?.coordinate)!;
        userLatitude = String(format: "%f",locValue.latitude);
        userLongtitude = String(format: "%f",locValue.longitude);
   
        
        stopRotation();
    }
}

extension SplashPage{
    func handleTestCoordinates(latitude: String, longitude: String){
//        let userID = standard.object(forKey: "userID") as! String;
        let userID = 0;
        let userLatitude = latitude;
        let userLongitude = longitude;
        //        userID = "0";
        let url = URL(string: "http://54.202.134.243:3000/load_headlines")!
        var request = URLRequest(url: url);
        let postBody = "userID=\(userID)&latitude=\(userLatitude)&longitude=\(userLongitude)"
        request.httpBody = postBody.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if(err != nil){
                //show error
                DispatchQueue.main.async {
//                    self.showErrorAlert();
                }
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response != "error"){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
                        print(json);
                        
                        DispatchQueue.main.async {
                            //headlineIDs,posterIDs,posterNames,descriptions,upVotes,downVotes,chatRoomPopulations,categories
                            let headlineIDs = json["headlineIDs"] as! NSArray;
                            let posterIDs = json["posterIDs"] as! NSArray;
                            let posterNames = json["posterNames"] as! NSArray;
                            let descriptions = json["descriptions"] as! NSArray;
                            let upVotes = json["upVotes"] as! NSArray;
                            let downVotes = json["downVotes"] as! NSArray;
                            let chatRoomPopulations = json["chatRoomPopulations"] as! NSArray;
                            let categories = json["categories"] as! NSArray;
                            let categoryIDs = json["categoryIDs"] as! NSArray;
                            let chatRoomIDs = json["chatRoomIDs"] as! NSArray;
                            
                            var count = 0;
                            while(count<headlineIDs.count){
                                
                                let headlineID = String(headlineIDs[count] as! Int);
                                _ = String(posterIDs[count] as! Int);
                                let posterName = posterNames[count] as! String;
                                let description = descriptions[count] as! String;
                                let upVote = upVotes[count] as! Int;
                                let downVote = downVotes[count] as! Int;
                                let chatRoomPop = chatRoomPopulations[count] as! Int;
                                let category = categories[count] as! String;
                                let categoryID = categoryIDs[count] as! Int;
                                let chatRoomID = chatRoomIDs[count] as! Int;
                                
                                let totalVoteCount = upVote - downVote;
                                
                                let newHeadline = Headline(headline: description, headlineID: headlineID,chatRoomID: chatRoomID, posterName: posterName, categoryName: category, categoryID: categoryID, voteCount: totalVoteCount, chatRoomPopulation: chatRoomPop, globalOrLocal: 0);
                                
//                                self.headlines.append(newHeadline);
                                count+=1;
                            }
                            
                            DispatchQueue.main.async {
                                
//                                self.localFeed.headlines = self.headlines;
//                                self.localFeed.reloadData();
//
//                                self.refreshControl.endRefreshing();
                                
                            }
                            
                            
                            
                        }
                    }catch{
                        print("error");
                    }
                }else{
                    //show error loading
                }
            }
        }
        task.resume();
    }
}
