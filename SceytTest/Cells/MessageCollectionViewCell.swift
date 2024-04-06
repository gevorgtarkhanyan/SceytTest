//
//  MessageCollectionViewCell.swift
//  SceytTest
//
//  Created by Gev on 03.04.24.
//

import UIKit

class MessageCell: UICollectionViewCell {
    let messageView = MessageView()
    var messageText = ""
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        contentView.addSubview(messageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageView.frame = contentView.bounds
        messageView.messageBackgroundColor = UIColor(hexString: "#F1F2F6")
        messageView.cornerRadius = 15
        messageView.imageView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 16)

    }
    
    func configure(with message: Message) {
        messageView.configure(time: message.messageTime, userImage: message.userImage, userName: message.userName, text: message.text, messageImage: message.image)
    }
}
