//
//  App.swift
//  App
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import DIGreatness

internal final class App
{

    internal var rootRouter: RootRouter?

    internal func run(in navigationController: UINavigationController)
    {
        let appPart = AppDIPart()
        do {
            try DI.load([appPart])
        }
        catch {
            assertionFailure("\(error)")
        }
        let navigator = Navigator(navigationController: navigationController)
        let router: RootRouter = appPart.rootRouerMaker(navigator)
        self.rootRouter = router
        router.active()
    }

}

