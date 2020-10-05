//
//  UICollectionViewCell+ReuseIdentifiable.swift
//  Created by Александр Чекель on 03.10.2020.
//

import UIKit

protocol UICollectionViewCellIdentifiable: UICollectionViewCell {}

extension UICollectionViewCellIdentifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String { return String(describing: self.self) }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCellIdentifiable>(cell: T) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCellIdentifiable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
}
