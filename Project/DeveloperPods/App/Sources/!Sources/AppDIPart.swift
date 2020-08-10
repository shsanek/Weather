//
//  AppDIPart.swift
//  App
//
//  Created by Alex Shipin on 10.08.2020.
//

import FastDI
import CitySearchUserStory
import WeatherUserStory

internal struct AppDIPart
{

    internal static func load(_ container: DIContainer)
    {
        WeathersDIPart.load(container)
        CitySearchDIPart.load(container)
        container.register {
            RootRouter(navigator: di_arg($0))
        }
        .injection(\.citySearchRouterMaker)
        .injection(\.weatherListRouterMaker)
    }

}
