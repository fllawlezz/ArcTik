//
//  Headline.swift
//  Squabble
//
//  Created by Brandon In on 10/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

class Headline: NSObject{
    var headline: String?;
    var headlineID: String?;
    var posterName: String?;
    var categoryName: String?;
    var categoryID: Int?;
    var voteCount: Int?;
    var chatRoomPopulation: Int?;
    var globalOrLocal: Int?
    var chatRoomID: Int?
    
    init(headline: String, headlineID: String, chatRoomID: Int, posterName: String, categoryName: String, categoryID: Int, voteCount: Int, chatRoomPopulation: Int, globalOrLocal: Int) {
        super.init();
        self.headline = headline;
        self.headlineID = headlineID;
        self.posterName = posterName;
        self.categoryName = categoryName;
        self.categoryID = categoryID;
        self.voteCount = voteCount;
        self.chatRoomPopulation = chatRoomPopulation;
        self.globalOrLocal = globalOrLocal;
        self.chatRoomID = chatRoomID;
    }
}
