//
//  App.swift
//  App
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import FastDI

internal final class App
{

    internal let container = DIContainer()
    internal var rootRouter: RootRouter?

    internal func run(in navigationController: UINavigationController)
    {
        AppDIPart.load(self.container)
        let navigator = Navigator(navigationController: navigationController)
        do
        {
            let router: RootRouter = try container.resolve(navigator)
            self.rootRouter = router
            router.active()
        }
        catch
        {
            fatalError("\(error)")
        }
    }

}

