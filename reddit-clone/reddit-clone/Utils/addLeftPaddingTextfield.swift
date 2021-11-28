//
//  addLeftPaddingTextfield.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/26.
//

import Foundation
import UIKit

//padding textfield (textfield 왼쪽에 빈공간 생성)
extension UITextField {
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

