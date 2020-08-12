//
//  AppDIPart.swift
//  App
//
//  Created by Alex Shipin on 10.08.2020.
//

import FastDI
import CitySearchUserStory
import WeatherUserStory
import Utils
import Design
import MainScreen

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
        .injection(\.mainScreenMaker)

        container.register(MainScreen.init)
        container.register(Skin.init)
        let session = URLSession(configuration: .default)
        container.register {
            session
        }
        container.register(NetworkService.init)
            .as(INetworkService.self)

        let imagesService = ImagesService(session: session)
        container.register { imagesService }
            .as(IImagesService.self)
    }

}
