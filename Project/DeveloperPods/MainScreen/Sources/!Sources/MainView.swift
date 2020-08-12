//
//  MainView.swift
//  MainScreen
//
//  Created by Alex Shipin on 12.08.2020.
//

import Design
import UIKit

internal final class MainView: UIView
{

    internal let bottomContainerView = UIView()
    internal let mainContainerView = UIView()

    private let config: MainViewLayoutConfig = MainViewLayoutConfig()
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var minBottomConstraint: NSLayoutConstraint?
    private var mainBottomConstraint: NSLayoutConstraint?
    private var keyboardHeight: CGFloat = 0.0

    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }

    internal init()
    {
        super.init(frame: .zero)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func open()
    {
        UIView.animate(withDuration: 1) {
            self.topConstraint?.isActive = true
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    public func close()
    {
        UIView.animate(withDuration: 1) {
            self.topConstraint?.isActive = false
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    private func addNotificationObserver()
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func keyBoardWillShow(notification: NSNotification)
    {

        if let frame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            self.keyboardHeight = frame.size.height
        }
        else
        {
            self.keyboardHeight = 0.0
        }
        if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Float
        {
            UIView.animate(withDuration: TimeInterval(animationDuration), animations: self.updateKeyboardPosition)
        }
        else
        {
            self.updateKeyboardPosition()
        }
    }

    private func updateKeyboardPosition()
    {
        self.mainBottomConstraint?.constant = -self.config.minBottomBarHeight - self.keyboardHeight
        self.bottomConstraint?.constant = -self.keyboardHeight
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    @objc private func keyBoardWillHide(notification: NSNotification)
    {
        self.keyboardHeight = 0.0
        if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Float
        {
            UIView.animate(withDuration: TimeInterval(animationDuration), animations: self.updateKeyboardPosition)
        }
        else
        {
            self.updateKeyboardPosition()
        }
    }

    private func configure()
    {
        self.addNotificationObserver()
        self.mainContainerView.backgroundColor = .clear
        self.bottomContainerView.backgroundColor = .clear
        self.bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainContainerView)
        self.addSubview(self.bottomContainerView)

        self.configureMainContainerLayout()
        self.configureBottomContainerLayout()
    }

    private func configureMainContainerLayout()
    {
        self.mainContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mainContainerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.mainContainerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.mainBottomConstraint = self.mainContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        self.mainBottomConstraint?.constant = -self.config.minBottomBarHeight
        self.mainBottomConstraint?.isActive = true
    }

    private func configureBottomContainerLayout()
    {
        self.bottomConstraint = self.bottomContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        self.bottomConstraint?.isActive = true
        self.bottomContainerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomContainerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.topConstraint = self.bottomContainerView.topAnchor.constraint(equalTo: self.topAnchor)
        self.topConstraint?.isActive = false
        let constraint = self.bottomContainerView.heightAnchor.constraint(equalToConstant: self.config.minBottomBarHeight)
        constraint.priority = .defaultHigh
        constraint.isActive = true
        self.minBottomConstraint = constraint
    }

}

internal struct MainViewLayoutConfig
{

    internal let barTopOfsset: CGFloat = 20.0
    internal let minBottomBarHeight: CGFloat = 100.0

}
