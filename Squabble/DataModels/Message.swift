//
//  File.swift
//  Squabble
//
//  Created by Brandon In on 10/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation


class Message: NSObject{
    var senderID: String?
    var senderName: String?
    var message: String?
    
    var chatRoomID: String?
    
    init(senderID: String, senderName: String, message: String){
        self.senderID = senderID;
        self.senderName = senderName;
        self.message = message;
    }
}
