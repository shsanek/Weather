//
//  Navigator.swift
//  Core
//
//  Created by Alex Shipin on 09.08.2020.
//

import UIKit

public final class Navigator: INavigator
{

    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }

    public func show(config: ShowContainer)
    {
        switch config
        {
        case .present(let config):
            self.present(with: config)
        case .push(let config):
            self.push(with: config)
        }
    }

    private func present(with config: ShowPresentConfig)
    {
        let viewController = config.screen.viewController
        self.navigationController.present(viewController,
                                          animated: true)
        let closeController = config.closeController
        closeController.closeHandler = { [navigationController, weak closeController, weak viewController] in
            guard let viewController = viewController else
            {
                return
            }
            if navigationController.presentedViewController == viewController
            {
                navigationController.dismiss(animated: true, completion: nil)
            }
            closeController?.closeHandler = nil
        }
    }

    private func push(with config: ShowPushConfig)
    {
        let viewController = config.screen.viewController
        self.navigationController.pushViewController(viewController, animated: true)
        let closeController = config.closeController
        closeController.closeHandler = { [navigationController, weak closeController, weak viewController] in
            guard let viewController = viewController else
            {
                return
            }
            if navigationController.viewControllers.last === viewController
            {
                navigationController.popViewController(animated: true)
            }
            else if navigationController.viewControllers.contains(viewController)
            {
                navigationController.viewControllers.removeAll(where: { $0 === viewController })
            }
            closeController?.closeHandler = nil
        }
    }

}
