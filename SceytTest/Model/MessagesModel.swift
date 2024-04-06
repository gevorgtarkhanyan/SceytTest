//
//  MessagesModel.swift
//  SceytTest
//
//  Created by Gev on 03.04.24.
//

import Foundation
import UIKit

struct Message {
    let userImage:UIImage?
    let userName:String?
    let messageTime:String?
    let text: String?
    let image: UIImage?
}

class MessagesViewModel {
    var messages: [Message] = []
    let pageSize: Int
    let messageView = MessageView()
 
    
    init(pageSize: Int = 20) {
        self.pageSize = pageSize
        self.fetchMessages()
    }
    
    func fetchMessages() {
        var userImages:[UIImage] = []
        var userNames:[String] = []
        var messageTimes:[String] = []
        var texts: [String] = []
        var messageImages: [UIImage] = []
        
        
        for userImageNumber in 1..<10 {
            userImages.append(UIImage(named: "userImage\(userImageNumber)") ?? UIImage())
        }
        
        for imageNumber in 1..<25 {
            messageImages.append(UIImage(named: imageNumber > 11 ? "" : "image\(imageNumber)") ?? UIImage())
        }
        
        userNames = ["James","Robert","John","Michael","David","William","Richard","Joseph","Thomas","Christopher","Charles","Daniel"]
        
        texts = ["when an unknown printer took a galley of type and scrambled it to make a type specimen book. It ha", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "Quisque consequat nisi nec ipsum placerat finibus. Maecenas dictum eu turpis eu ornare. Nullam aliquet facilisis volutpat.Praesent risus dolor, iaculis vel feugiat et, pellentesque a urna.",]
        
        messageTimes = ["11:30","12:30","16:14","24:00","23:54","16:17","18:54","16:17","13:26","12:41"]
        
    
        
   
        // Simulate fetching messages from local data
        for _ in 0..<1000 {
            let randomImage = messageImages.randomElement()
            let randomUserImage = userImages.randomElement()
            let randomMessageTime = messageTimes.randomElement()
            let randomText = texts.randomElement()
            let randomUserName = userNames.randomElement()
            
            let message = Message(userImage: randomUserImage, userName: randomUserName, messageTime: randomMessageTime,text: randomText, image: randomImage)
            messageView.configure(time: message.messageTime, userImage: message.userImage, userName: message.userName, text: message.text, messageImage: message.image)
            messages.append(message)
        }
    }

    
    func numberOfMessages() -> Int {
        return messages.count
    }
    
    private func getTime() -> String {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: now)
        var timeString = ""
        if let hour = components.hour, let minute = components.minute {
            timeString = String(format: "%02d:%02d", hour, minute)
          
        }
        return timeString
    }
    
    func message(at index: Int) -> Message? {
        guard index >= 0 && index < messages.count else { return nil }
        return messages[index]
    }
}
