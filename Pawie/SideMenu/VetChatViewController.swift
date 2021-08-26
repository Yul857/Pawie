//
//  VetChatViewController.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/25/21.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase
import SDWebImage
//import MessageKit

class VetChatViewController: MessagesViewController, MessagesDataSource, MessagesDisplayDelegate {
    
    //MARK: - Properties
    private let uid = Auth.auth().currentUser?.uid
    var messages = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        maintainPositionOnKeyboardFrameChanged = true
        scrollsToLastItemOnKeyboardBeginsEditing = true
        
        messageInputBar.inputTextView.tintColor = .systemBlue
        messageInputBar.sendButton.setTitleColor(.systemTeal, for: .normal)
        
        messageInputBar.delegate = self
        
        loadMessages()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - API
    func loadMessages() {
        ConsultService.loadMessages { messages in
            self.messages = messages
            self.messagesCollectionView.reloadData()
        }
    }
    
    //MARK: - helpers
    
    func currentSender() -> SenderType {
        return ChatUser(senderId: Auth.auth().currentUser?.uid ?? "self", displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }


}

//MARK: - InputBarAccessoryViewDelegate

extension VetChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.fetchUser(withUid: uid) { user in
            let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: uid, senderName: user.ownername)
            
            //messages.append(message)
            ConsultService.uploadMessages(message: message) { error in
                if let error = error {
                    print("DEBUG: Having trouble saving message \(error)")
                }
            }
        }
        
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
}

//MARK: - MessageLayoutDelegate

extension VetChatViewController: MessagesLayoutDelegate {
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    // MARK: - MessagesDisplayDelegate
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .blue: .lightGray
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.fetchUser(withUid: uid) { user in
            if message.sender.senderId == uid {
                SDWebImageManager.shared.loadImage(with: URL(string: user.profileImageURL), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                    avatarView.image = image
                }
            }
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
        
    }
}



