//
//  MessagesViewController.swift
//  SceytTest
//
//  Created by Gev on 03.04.24.
//

import UIKit

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private var inputTextView: InputTextView!
    @IBOutlet weak var inputTextViewBottomConstraint: NSLayoutConstraint!
    
    private var viewModel: MessagesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MessagesViewModel()
        setupInputTextView()
        addObserver()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        scrollToBottom()
    }
    
    deinit {
        // Remove keyboard notifications observer
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func addObserver() {
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    private func scrollToBottom() {
        let lastSection = collectionView.numberOfSections - 1
        let lastItem = collectionView.numberOfItems(inSection: lastSection) - 1
        let lastIndexPath = IndexPath(item: lastItem, section: lastSection)
        
        collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    
    private func setupInputTextView() {
        inputTextView.delegate = self
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc public func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            inputTextViewBottomConstraint.constant = keyboardHeight
        }
        
    }
    
    @objc public func keyboardWillHide(_ sender: Notification) {
        inputTextViewBottomConstraint.constant = 0
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
}

extension MessagesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfMessages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as? MessageCell else {
            return UICollectionViewCell()
        }
        
        if let message = viewModel.message(at: indexPath.section) {
            cell.configure(with: message)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHeight = viewModel.messageView.setupSizes(text: (viewModel.message(at: indexPath.section)?.text)!, userName: (viewModel.message(at: indexPath.section)?.userName)!)
        return CGSize(width: CGFloat(collectionView.frame.width), height:  viewModel.message(at: indexPath.section)?.image?.size.width == 0 ? totalHeight : totalHeight + 200)
     
    }
}

extension MessagesViewController: InputTextViewDelegate{
    
    func didTapAttachButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func didTapSendButton(text: String) {
            viewModel.messages.append(Message(userImage: UIImage(), userName: "", messageTime: "\(getTime())", text: text, image: UIImage()))
            collectionView.reloadData()
            scrollToBottom()
        }
 
    }


extension MessagesViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              // Do something with the picked image
              viewModel.messages.append(Message(userImage: UIImage(), userName: "", messageTime: "\(getTime())", text: "", image: pickedImage))
              collectionView.reloadData()
              scrollToBottom()
          }
          picker.dismiss(animated: true, completion: nil)
      }

      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true, completion: nil)
      }
    
}
