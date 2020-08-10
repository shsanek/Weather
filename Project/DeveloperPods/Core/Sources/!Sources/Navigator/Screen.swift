//
//  Screen.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

public struct Screen: IScreen
{

    public let viewController: UIViewController

    public init(viewController: UIViewController)
    {
        self.viewController = viewController
    }

}
