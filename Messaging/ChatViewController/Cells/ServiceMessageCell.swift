//
//  ServiceMessageCell.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import UIKit

class ServiceMessageCell: UITableViewCell, UITableViewCellIdentifiable {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    public func set(message: ServiceMessage) {
        messageLabel.text = message.text
    }

}
