//
//  ChatViewController.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import UIKit

class ChatViewController: UIViewController {
    
    enum Section: Hashable {
        case serviceMessage(ServiceMessage)
        case incomingMessage(ChatMessage)
        case outgoingMessage(ChatMessage)
    }
    
    struct Update {
        let add: [Section]
        let remove: [Section]
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textInputBarContainer: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var inputBarSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet var inputBarBottomConstraint: NSLayoutConstraint!
    
    private var isInverted: Bool = true
    private var heightCache: [IndexPath : CGFloat] = [:]
    private var messages: [Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages = [
            .serviceMessage(ServiceMessage(text: "Вчера")),
            .incomingMessage(ChatMessage(text: "АНДРЕЙ ЗДАРОВА")),
            .serviceMessage(ServiceMessage(text: "Сегодня")),
            .incomingMessage(ChatMessage(text: "ПИШУ ТЕБЕ СНОВА"))
        ]
        
        messages = isInverted ? messages.reversed() : messages
        tableView.transform = isInverted ? CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0) : .identity
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let topInset: CGFloat = topbarHeight
        let bottomInset: CGFloat = textInputBarContainer.bounds.height
        
        tableView.contentInset.top = isInverted ? bottomInset : topInset
        tableView.contentInset.bottom = isInverted ? topInset : bottomInset
        tableView.verticalScrollIndicatorInsets.top = isInverted ? bottomInset : topInset
        tableView.verticalScrollIndicatorInsets.bottom = isInverted ? topInset : bottomInset
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func sendMessage() {
        guard let text = textField.text, text != "" else { return }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let msg = ChatMessage(text: trimmed)
        textField.text = nil
        
        tableView.performBatchUpdates({ [self] in
            if isInverted {
                messages.insert(.outgoingMessage(msg), at: 0)
                tableView.insertSections(IndexSet(integer: 0), with: .fade)
            } else {
                messages.append(.outgoingMessage(msg))
                tableView.insertSections(IndexSet(integer: messages.count - 1), with: .fade)
            }
        }, completion: nil)
        
        if !isInverted {
            tableView.scrollToRow(at: IndexPath(row: 0, section: messages.count - 1), at: .bottom, animated: true)
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        sendMessage()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let height = value.cgRectValue.height
        
        NSLayoutConstraint.deactivate([inputBarSafeAreaConstraint])
        NSLayoutConstraint.activate([inputBarBottomConstraint])
        
        inputBarBottomConstraint.constant = height
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        NSLayoutConstraint.deactivate([inputBarBottomConstraint])
        NSLayoutConstraint.activate([inputBarSafeAreaConstraint])
        view.layoutIfNeeded()
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightCache[indexPath] = cell.bounds.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCache[indexPath] ?? 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch messages[indexPath.section] {
            case .serviceMessage(let message):
                let serviceMessageCell: ServiceMessageCell = tableView.dequeueReusableCell(for: indexPath)
                serviceMessageCell.set(message: message)
                cell = serviceMessageCell
            case .incomingMessage(let message):
                let incomingMessageCell: IncomingMessageCell = tableView.dequeueReusableCell(for: indexPath)
                incomingMessageCell.set(message: message)
                cell = incomingMessageCell
            case .outgoingMessage(let message):
                let outgoingMessageCell: OutgoingMessageCell = tableView.dequeueReusableCell(for: indexPath)
                outgoingMessageCell.set(message: message)
                cell = outgoingMessageCell
        }
        
        cell.transform = tableView.transform
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField.endEditing(true)
    }
    
    
}
