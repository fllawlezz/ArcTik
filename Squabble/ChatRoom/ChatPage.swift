//
//  ChatPage.swift
//  Squabble
//
//  Created by Brandon In on 7/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import SocketIO

let pauseSocketNotification = "pauseSocketNotification";
let resumeSocketNotification = "resumeSocketNotification";

protocol ChatPageDelegate{
    func resetNavigationBar();
}

class ChatPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate, SendMessageViewDelegate, ChatHeadlineBottomBarDelegate{
    
    let manager = SocketManager(socketURL: URL(string:"http://ec2-54-202-134-243.us-west-2.compute.amazonaws.com:3000/")!, config: [.log(true),.connectParams(["token":"ABC438s"])])
    
    var socket: SocketIOClient!;
    
    var name: String?;
    var userID: String?;
    var chatRoomID: String?;
    
    var localFeedPage: LocalFeed?;
    var globalFeedPage: GlobalFeed?;
    
    let headlineReuse = "headline";
    let userMessageReuse = "userMessage";
    let otherMessageReuse = "otherMessage";
    
    var thisHeadline: Headline?;
    
    var messages = [Message]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        addObservers();
        setupHandles();
        setupSocket();
        localFeedPage?.handleCancel();//resets navigation bar
        self.navigationItem.title = "Category";
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.montserratSemiBold(fontSize: 16)];
        navigationController?.navigationBar.titleTextAttributes = textAttributes;
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        self.collectionView?.register(ChatHeadlineCell.self, forCellWithReuseIdentifier: headlineReuse);
        self.collectionView?.register(UserMessageCell.self, forCellWithReuseIdentifier: userMessageReuse);
        self.collectionView?.register(OtherMessageCell.self, forCellWithReuseIdentifier: otherMessageReuse);
        self.collectionView?.delegate = self;
        self.collectionView?.dataSource = self;
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.keyboardDismissMode = .interactive;
        
        //load messages
        self.loadMessages();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let userData = ["userID": self.userID!,"chatRoomID":self.chatRoomID!];
        socket.emit("endSocket", with: [userData]);
        manager.disconnect()
    }
    
    func setupHandles(){
        self.name = (standard.object(forKey: "userName") as! String);
        self.userID = (standard.object(forKey: "userID") as! String);
        self.chatRoomID = "\(self.thisHeadline!.chatRoomID!)";
        
//        print("userID:\(self.userID!)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func addObservers(){
        let pauseName = Notification.Name(rawValue: pauseSocketNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopSocket), name: pauseName, object: nil);
        
        let resumeName = Notification.Name(rawValue: resumeSocketNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resumeSocket), name: resumeName, object: nil);
    }
    
    func setupSocket(){
        self.socket = manager.defaultSocket;
        self.socket.on("chatRoomPopulation") { (data, ack) in
            let chatPopulation = data[0] as! Int;
            self.thisHeadline?.chatRoomPopulation = chatPopulation;
            let info = ["population":chatPopulation];
            let name = Notification.Name(rawValue: updateChatPopulationNotification);
            NotificationCenter.default.post(name: name, object: nil, userInfo: info);
        }
        self.socket.on(clientEvent: .connect) { (args, ack) in
            let userData = ["userID":self.userID!, "chatRoomID": self.chatRoomID!];
            self.socket.emit("userSetup", with: [userData]);
        }
        
        self.socket.on("messageRecieved") { (data, acks) in
            let senderData = data[0] as! NSDictionary;
            let senderID = senderData["userID"] as! String;
            let senderName = senderData["senderName"] as! String;
            let message = senderData["message"] as! String;
            let chatRoomID = senderData["chatRoomID"] as! String;
            
            let recievedMessage = Message(senderID: senderID, senderName: senderName, message: message);
            recievedMessage.chatRoomID = chatRoomID;
            self.messages.append(recievedMessage);
            
            let insertIndex = IndexPath(item: self.messages.count-1, section: 1);
            self.collectionView?.insertItems(at: [insertIndex]);
            
            self.scrollToBottom();
        }
        
        self.socket.on(clientEvent: .error) { (args, ack) in
            let alert = UIAlertController(title: "Oops!", message: "You can't connect with our servers! Please try again later", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.socket.disconnect();
                self.manager.disconnect();
                self.navigationController?.popViewController(animated: true);
            }))
            self.present(alert, animated: true, completion: nil);
        }
        
        self.socket.connect();
                
    }
    
    lazy var sendMessageView: SendMessageView = {
        let sendMessageView = SendMessageView();
        sendMessageView.messageField.delegate = self;
        sendMessageView.sendMessageViewDelegate = self;
        return sendMessageView;
    }()

    
    override var inputAccessoryView: UIView?{
        get{
            return sendMessageView;
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true;
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = "";
        textView.textColor = UIColor.black;
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headlineReuse, for: indexPath) as! ChatHeadlineCell
            cell.thisHeadline = self.thisHeadline;
            cell.chatHeadlineBottomBarDelegate = self;
            return cell;
        }else{
            let currentMessage = messages[indexPath.item];
            
            if(currentMessage.senderID! == self.userID!){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userMessageReuse, for: indexPath) as! UserMessageCell
                cell.setUserMessageText(message: currentMessage.message!);
                cell.bubbleWidthAnchor?.constant = self.estimateFrameForText(message: currentMessage.message!).width+20;
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherMessageReuse, for: indexPath) as! OtherMessageCell
//                cell.backgroundColor = UIColor.red;
//                cell.senderNameLabel.backgroundColor = UIColor.blue;
                cell.senderNameLabel.isHidden = false;
//                if(messages.count > 1 && indexPath.item > 0){
//                    if(currentMessage.senderID! == messages[indexPath.item-1].senderID!){
//                        cell.senderNameLabel.isHidden = true;
//                    }
//                }
                cell.bubbleViewWidthAnchor?.constant = self.estimateFrameForText(message: currentMessage.message!).width+20;
                cell.setMessage(message: currentMessage.message!);
                cell.setSenderName(name: currentMessage.senderName!);
                return cell;
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1;
        }else{
            return messages.count;
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: self.view.frame.width, height: 150);
        }else{
            let currentMessage = messages[indexPath.item];
            if(currentMessage.senderID! == self.userID!){
//                let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50);
//                let dummyCell = UserMessageCell(frame: frame);
//                dummyCell.messageTextView.text = currentMessage.message!;
//                dummyCell.layoutIfNeeded();
//
//                let targetSize = CGSize(width: self.view.frame.width, height: 1000);
//                let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize);
                
                let frame1 = estimateFrameForText(message: currentMessage.message!);
//                return CGSize(width: self.view.frame.width, height: estimatedSize.height+20);
                return CGSize(width: self.view.frame.width, height: frame1.height+25);
            }else{
                
                let frame = estimateFrameForText(message: currentMessage.message!);
//                if(messages.count > 2 && indexPath.item > 0){
//                    let previousMessage = messages[indexPath.item - 1];
//                    if(currentMessage.senderID! == previousMessage.senderID!){
//                        return CGSize(width: self.view.frame.width, height: frame.height+30);
//                    }
//                }
                
                return CGSize(width: self.view.frame.width, height: frame.height+25+30);
                
//                let frame = estimateFrameForText(message: currentMessage.message!);
//                return CGSize(width: self.view.frame.width, height: frame.height+30+25);
            }
        }
    }
    
    private func estimateFrameForText(message: String)->CGRect{
        let approximateWidthOfChatCell = 200;
        let size = CGSize(width: approximateWidthOfChatCell, height: 1000);
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)];
        let estimatedFrame = NSString(string: message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil);
        return estimatedFrame;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: resignSendMessageView);
        NotificationCenter.default.post(name: name, object: nil);
    }
}

extension ChatPage{
    @objc func stopSocket(){
//        print("stopped socket");
        let userData = ["userID": self.userID!,"chatRoomID":self.chatRoomID!];
        socket.emit("endSocket", with: [userData]);
        self.manager.disconnect();
        self.socket.disconnect();
    }
    
    @objc func resumeSocket(){
//        print("reconnected socket");
        self.socket.connect();
    }
}


extension ChatPage{
    func scrollToBottom() {
        if(messages.count>3){
            let indexPath = IndexPath(row: self.messages.count-1, section: 1);
            self.collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true);
        }
    }
    
    func sendMessage(message: String){
        //senderID, senderName, message, chatRoomID, anonymous
        if(message.count > 0){
            let socketData = ["userID":self.userID!, "senderName":self.name!,"message":message,"chatRoomID":self.chatRoomID!];
//            print(socketData);
            self.socket.emit("sendMessage", with: [socketData]);
            
            let message = Message(senderID: self.userID!, senderName: self.name!, message: message);
            self.messages.append(message);
            
            let insertIndexPath = IndexPath(item: self.messages.count-1, section: 1);
            self.collectionView?.insertItems(at: [insertIndexPath]);
            
            self.scrollToBottom();
        }
    }
    
    func showFlagAlert(){
        let alert = UIAlertController(title: "Flag?", message: "Flag this post as being inappropriate?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            print("flagged");
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Ugh-Oh", message: "There was a problem connecting to our servers... sorry for the inconvenience. Try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action) in
            self.manager.disconnect();
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
}


extension ChatPage{
    func loadMessages(){
        let url = URL(string: "http://54.202.134.243:3000/load_messages")!;
        var request = URLRequest(url: url);
        let body = "chatRoomID=\(self.thisHeadline!.chatRoomID!)";
        print(body);
        request.httpBody = body.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if(err != nil){
                //show error
                DispatchQueue.main.async {
                    self.showErrorAlert();
                    return;
                }
            }
            
            if(data != nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                    
                    DispatchQueue.main.async {
                        //messageId, SenderID, senderName, chatRoomID, anonymous, message
                        let messageIDs = json["messageIDs"] as! NSArray;
                        let senderIDs = json["senderIDs"] as! NSArray;
                        let senderNames = json["senderNames"] as! NSArray;
//                        let anonymousArray = json["anonymousArray"] as! NSArray;
                        let messages = json["messages"] as! NSArray;
//                        print("\(messageIDs.count) message count");
                        var count = 0;
                        while(count<messageIDs.count){
                            let senderID = String(senderIDs[count] as! Int);
                            let senderName = senderNames[count] as! String;
                            let message = messages[count] as! String;
                            let newMessage = Message(senderID: senderID, senderName: senderName, message: message);
                            self.messages.append(newMessage);
                            count+=1;
                        }
                        
                        self.collectionView?.reloadData();
                        
                    }
                }catch{
                    print("error");
                }
            }
        }
        task.resume()
    }
}
