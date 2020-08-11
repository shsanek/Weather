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
            WeatherListScreenPresenter(ui: di_arg($0),
                                       weathersService: $1,
                                       imagesService: $2)
        }
        container.register(WeatherListScreenUI.init)
        container.register(WeathersServiceConfigure.init)
        container.register(WeathersService.init)
            .as(IWeathersService.self)
        container.register {
            WeatherListRouter(navigator: di_arg($0),
                              builder: $1,
                              detailsScreenBuilder: $2)
        }
        container.register(ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>.init)
            .injection(\.presenterMaker)
            .injection(\.uiMaker)
        container.register {
            WeatherDetailsPresenter(ui: di_arg($0), config: di_arg($1))
        }
        container.register(WeatherDetailsUI.init)
        container.register(ScreenBuilderWithArgument<WeatherDetailsPresenter, WeatherDetailsUI, WeatherDetailsPresenterConfig>.init)
            .injection(\.presenterMaker)
            .injection(\.uiMaker)
    }

}

