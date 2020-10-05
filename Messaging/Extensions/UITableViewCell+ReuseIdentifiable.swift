//
//  UITableViewCell+ReuseIdentifiable.swift
//  Created by Александр Чекель on 01.10.2020.
//

import UIKit

protocol UITableViewCellIdentifiable: UITableViewCell {}

extension UITableViewCellIdentifiable where Self: UITableViewCell {
    static var reuseIdentifier: String { return String(describing: self.self) }
}

extension UITableView {
    
    func register<T: UITableViewCellIdentifiable>(cell: T) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCellIdentifiable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
}
