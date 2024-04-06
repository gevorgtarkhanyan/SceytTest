//
//  InputText.swift
//  SceytTest
//
//  Created by Gev on 03.04.24.
//

import UIKit

protocol InputTextViewDelegate: AnyObject {
    func didTapSendButton(text: String)
    func didTapAttachButton()
}

class InputTextView: UIView {
    weak var delegate: InputTextViewDelegate?
    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var attachButton: UIButton!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupViews()
    }
    
    private func setupViews() {
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 20
       
    }
    
    
    
    private func commonInit() {
        let bundle = Bundle.init(for: InputTextView.self)
        if let viewToAdd = bundle.loadNibNamed("InputTextView", owner: self,options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    
    @IBAction func attachButtonAction(_ sender: Any) {
        delegate?.didTapAttachButton()
    }
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty else { return }
        delegate?.didTapSendButton(text: text)
        textField.text = ""
    }
    
 
}


