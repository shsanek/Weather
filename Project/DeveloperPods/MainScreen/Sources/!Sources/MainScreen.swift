//
//  MainScreen.swift
//  MainScreen
//
//  Created by Alex Shipin on 12.08.2020.
//

import Design
import UIKit
import Core

public final class MainScreen: IScreen
{

    public var viewController: UIViewController {
        return self.mainViewController
    }

    private lazy var mainViewController = MainViewController(skin: self.skin)
    private let skin: Skin
    public init(skin: Skin)
    {
        self.skin = skin
    }

    public func setMainContent(screen: IScreen)
    {
        self.mainViewController.mainContainerViewController = screen.viewController
    }

    public func setBottomContent(screen: IScreen)
    {
        self.mainViewController.bottomContainerViewController = screen.viewController
    }

    public func open()
    {
        self.mainViewController.open()
    }

    public func close()
    {
        self.mainViewController.close()
    }
}
