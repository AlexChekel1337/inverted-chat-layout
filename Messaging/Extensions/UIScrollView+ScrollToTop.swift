//
//  UIScrollView+ScrollToTop.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import UIKit

extension UIScrollView {
    func scrollToTop() {
        let sel = Selector(("_scrollToTopIfPossible:"))
        if responds(to: sel) {
            perform(sel, with: false as NSNumber)
        }
    }
}
