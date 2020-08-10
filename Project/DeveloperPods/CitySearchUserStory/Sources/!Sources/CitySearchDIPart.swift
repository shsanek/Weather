//
//  CitySearchDIPart.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import FastDI
import Core

public struct CitySearchDIPart
{

    public static func load(_ container: DIContainer)
    {
        container.register {
            CitySearchScreenPresenter(ui: di_arg($0))
        }
        container.register(CitySearchScreenUI.init)
        container.register(CitySearchService.init)
            .as(ICitySearchService.self)
        container.register(CitySearchRouter.init)
        container.register(ScreenBuilder<CitySearchScreenPresenter, CitySearchScreenUI>.init)
            .injection(\.presenterMaker)
            .injection(\.uiMaker)
    }

}
