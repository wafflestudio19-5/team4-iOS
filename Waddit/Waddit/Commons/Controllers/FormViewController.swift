//
//  FormViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/28.
//

import UIKit

class FormViewController: UIViewController {

    var lowestElement: UIView!

    var moveLowestElement: Bool = false

    // Should have keyboardDismissMode to interactive
    var scrollView: UIScrollView!
    var formContainerStackView: UIStackView!

    // a function to make sure the interface keyboards go down
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func viewWillAppear(_ animated: Bool) {
        setupKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotification()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if formContainerStackView.frame.height > view.frame.height {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        }

        _ = distanceToBottom
    }

    lazy var distanceToBottom = self.distanceFromLowestElementToBottom()

    func distanceFromLowestElementToBottom() -> CGFloat {
        if lowestElement != nil {
            guard let frame = lowestElement.superview?.convert(lowestElement.frame, to: view) else { return 0 }
            let distance = view.frame.height - frame.origin.y - frame.height
            return distance
        }

        return view.frame.height - formContainerStackView.frame.maxY
    }

    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        print("a")
        scrollView.contentInset.bottom = keyboardFrame.height

        // when stackView is center aligned, we need some extra bottom padding, not sure why yet...

        if distanceToBottom > 0 {
            scrollView.contentInset.bottom -= distanceToBottom
        }

        self.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: -keyboardFrame.height, left: 0, bottom: keyboardFrame.height, right: 0)

        if moveLowestElement {
            lowestElement.frame.origin.y = keyboardFrame.origin.y - lowestElement.frame.height
        }

    }

    @objc
    func handleKeyboardHide(notification: Notification) {
        if moveLowestElement {
            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = value.cgRectValue
            lowestElement.frame.origin.y += keyboardFrame.height
        }
        self.scrollView.contentInset.bottom = 0
        self.scrollView.scrollIndicatorInsets.bottom = 0

    }

    public enum FormAlignment {
        case top, center
    }

    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
