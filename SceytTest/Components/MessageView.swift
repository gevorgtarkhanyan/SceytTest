//
//  MessageView.swift
//  SceytTest
//
//  Created by Gev on 04.04.24.
//

import Foundation
import UIKit

class MessageView: UIView,UITextViewDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var messageTime: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var messageTextLabel: UILabel!
    
    
    @IBOutlet var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: UIView!
    @IBOutlet var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameLabelHeight: NSLayoutConstraint!
    
    
    var messageBackgroundColor: UIColor = .white {
        didSet {
            updateUI()
        }
    }
    
    var cornerRadius: CGFloat = 8.0 {
        didSet {
            updateUI()
        }
    }
    
    var textSize: CGFloat = 16.0 {
        didSet {
            updateUI()
        }
    }
    
    
    var totalHeight:CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupUI()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: MessageView.self)
        if let viewToAdd = bundle.loadNibNamed("MessageView", owner: self,options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    

    private func updateUI() {
        contentView.backgroundColor = self.messageBackgroundColor
        contentView.layer.cornerRadius = cornerRadius
        messageTextLabel.font = UIFont.systemFont(ofSize: textSize)
    }
    
    func configure(time:String? , userImage:UIImage?, userName:String?, text: String?, messageImage: UIImage?) {
        userImageView.image = userImage
        userNameLabel.text = userName
        messageTime.text = time
        messageTextLabel.text = text
        imageView.image = messageImage
        

        if messageImage?.size.width == 0 {
            imageViewHeight.constant = 0
            imageViewTopConstraint.constant = 26
            messageTime.backgroundColor = .clear
            messageTime.textColor = UIColor(hexString: "#707388")
        } else if text == "" {
            imageView.layer.cornerRadius = 16
            imageViewTopConstraint.constant = 8
            imageViewHeight.constant = 200
        } else {
            imageViewTopConstraint.constant = 8
            imageViewHeight.constant = 200
        }
    }
    
    func setupSizes(text:String,userName:String) -> CGFloat {
        userNameLabelHeight.constant = userName == "" ? 0 : 20
        let labelHeight = heightForView(text: text , font: messageTextLabel.font, width: contentView.frame.width)
        totalHeight = CGFloat(labelHeight)  + userNameLabelHeight.constant + (labelHeight == 0 ? 0 : 60) + (imageView.image?.size.width == 0 ? 20 : 0)
        return totalHeight
    }

    private func setupUI() {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        messageTime.layer.cornerRadius = 12
        messageTextLabel.numberOfLines = 0
        messageTextLabel.lineBreakMode = .byWordWrapping
        messageTextLabel.sizeToFit()
    }
    
    private func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    
}
