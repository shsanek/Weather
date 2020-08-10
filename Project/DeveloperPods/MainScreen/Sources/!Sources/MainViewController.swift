//
//  MainViewController.swift
//  Core
//
//  Created by Alex Shipin on 10.08.2020.
//

import UIKit
import Core

public protocol IMainDelegate
{

    func didOpen()
    func didClose()

}


public struct MainScreen: IScreen
{

    public var viewController: UIViewController {
        return self.mainViewController
    }

    private var mainViewController = MainViewController()

    public init()
    {
    }

    public func setMainContent(screen: IScreen)
    {
        self.mainViewController.mainContainerViewController = screen.viewController
    }

    public func setBottomContent(screen: IScreen)
    {
        self.mainViewController.bottomContainerViewController = screen.viewController
    }
}

internal final class MainViewController: UIViewController
{

    internal var mainContainerViewController: UIViewController? {
        didSet {
            oldValue.flatMap(self.removeSubcontroller)
            if let vc = self.mainContainerViewController
            {
                self.addSubcontroller(viewController: vc,
                                      in: self.mainView.mainContainerView)
            }
        }
    }

    internal var bottomContainerViewController: UIViewController? {
        didSet {
            oldValue.flatMap(self.removeSubcontroller)
            if let vc = self.bottomContainerViewController
            {
                self.addSubcontroller(viewController: vc,
                                      in: self.mainView.bottomContainerView)
            }
        }
    }

    private let mainView = MainView()

    internal init()
    {
        super.init(nibName: nil, bundle: nil)
    }

    internal override func loadView()
    {
        self.view = self.mainView
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    private func removeSubcontroller(viewController: UIViewController)
    {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    private func addSubcontroller(viewController: UIViewController, in view: UIView)
    {
        self.addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.mainContainerView.addSubview(viewController.view)
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.didMove(toParent: self)
    }

}

internal struct MainViewLayoutConfig
{

    internal let barTopOfsset: CGFloat = 20.0
    internal let minBottomBarHeight: CGFloat = 100.0

}

internal final class MainView: UIView
{

    internal let bottomContainerView = UIView()
    internal let mainContainerView = UIView()

    private let config: MainViewLayoutConfig = MainViewLayoutConfig()
    private var topConstraint: NSLayoutConstraint?
    private var minBottomConstraint: NSLayoutConstraint?
    private var mainBottomConstraint: NSLayoutConstraint?

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
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.isActive = true
        }
    }

    public func close()
    {
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.isActive = false
        }
    }

    private func configure()
    {
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
        self.bottomContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomContainerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomContainerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.topConstraint = self.mainContainerView.bottomAnchor.constraint(equalTo: self.topAnchor)
        self.topConstraint?.isActive = false
        let constraint = self.bottomContainerView.heightAnchor.constraint(equalToConstant: self.config.minBottomBarHeight)
        constraint.priority = .defaultHigh
        constraint.isActive = true
        self.minBottomConstraint = constraint
    }

}
