//
//  WeathersDIPart.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import FastDI
import Core

public struct WeathersDIPart
{

    public static func load(_ container: DIContainer)
    {
        container.register {
            WeatherListScreenPresenter(ui: di_arg($0))
        }
        container.register(WeatherListScreenUI.init)
        container.register(WeathersService.init)
            .as(IWeathersService.self)
        container.register(WeatherListRouter.init)
        container.register(ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>.init)
            .injection(\.presenterMaker)
            .injection(\.uiMaker)
    }

}
