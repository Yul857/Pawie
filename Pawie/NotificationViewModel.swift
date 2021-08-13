//
//  NotificationViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/11/21.
//

import UIKit


struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "")}
    var profileImageUrl: URL? {return URL(string: notification.userProfileImageUrl)}
    
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timeStamp.dateValue(), to: Date())
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 15)]))
        attributedText.append(NSAttributedString(string: "  \(timeStampString ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 12),
                                                                              .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
    var shouldHidePostImage: Bool {
        return self.notification.type == .follow
    }
    
    var followButtonText: String { return notification.userIsFollowed ? "following" : "follow"}
    
    var followbuttonBackgroundcolor: UIColor {return notification.userIsFollowed ? .white : .systemBlue}
    
    var followButtonTextColor: UIColor {return notification.userIsFollowed ? .black : .white}
}
