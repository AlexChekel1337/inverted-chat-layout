//
//  OutgoingMessageCell.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import UIKit

class OutgoingMessageCell: UITableViewCell, UITableViewCellIdentifiable {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.layer.masksToBounds = true
        bubbleView.layer.cornerRadius = 18.5
        bubbleView.layer.cornerCurve = .continuous
        
        messageTextView.textContainerInset = .zero
        messageTextView.textContainer.lineFragmentPadding = 0
    }
    
    public func set(message: ChatMessage) {
        messageTextView.text = message.text
    }

}
