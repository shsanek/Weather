//
//  WeathersDIPart.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import DIGreatness
import Core

public struct WeathersDIPart: DIPart
{
    public init() { }

    public func registration(_ registrator: DIRegistrator) throws {
        try registrator.register {
            WeatherListScreenPresenter(ui: diArg($0) as WeatherListScreenUI,
                                       weathersService: $1,
                                       imagesService: $2)
        }
        try registrator.register(WeatherListScreenUI.init)
        try registrator.register(WeathersServiceConfigure.init)
        try registrator.register(WeathersService.init)
            .map { $0 as IWeathersService }
        try registrator.register {
            WeatherListRouter(navigator: diArg($0),
                              builder: $1,
                              detailsScreenBuilder: $2)
        }
        try registrator.register(ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>.init)
        try registrator.register {
            WeatherDetailsPresenter(ui: diArg($0) as WeatherDetailsUI, config: diArg($1), imagesService: $2)
        }
        try registrator.register(WeatherDetailsUI.init)
        try registrator.register(ScreenBuilderWithArgument<WeatherDetailsPresenter, WeatherDetailsUI, WeatherDetailsPresenterConfig>.init)
    }

}

