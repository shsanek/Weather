//
//  MainViewController.swift
//  Core
//
//  Created by Alex Shipin on 10.08.2020.
//

import UIKit
import Core
import Design

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
    private let skin: Skin
    

    internal init(skin: Skin)
    {
        self.skin = skin
        super.init(nibName: nil, bundle: nil)
    }

    internal override func loadView()
    {
        self.view = self.mainView
        self.view.backgroundColor = self.skin.palette.background.main
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    internal func open()
    {
        self.mainView.open()
    }

    internal func close()
    {
        self.mainView.close()
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
        view.addSubview(viewController.view)
        viewController.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.didMove(toParent: self)
    }

}
