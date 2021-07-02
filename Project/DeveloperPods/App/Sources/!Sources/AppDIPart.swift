//
//  AppDIPart.swift
//  App
//
//  Created by Alex Shipin on 10.08.2020.
//

import DIGreatness
import CitySearchUserStory
import WeatherUserStory
import Utils
import Design
import MainScreen
import Core

internal struct AppDIPart: DIPart
{
    @DIInject var rootRouerMaker: (INavigator) -> RootRouter
    
    var subpars: [DIPart] {
        [WeathersDIPart(), CitySearchDIPart()]
    }

    func registration(_ registrator: DIRegistrator) throws {
        try registrator.register(RootRouter.RoutersFactory.init)
        try registrator.register {
            RootRouter(navigator: diArg($0), factory: $1)
        }
        try registrator.register(MainScreen.init)
        try registrator.register(Skin.init)
        let session = URLSession(configuration: .default)
        try registrator.register {
            session
        }
        try registrator.register(NetworkService.init)
            .map { $0 as INetworkService }

        let imagesService = ImagesService(session: session)
        try registrator.register { imagesService }
            .map { $0 as IImagesService }
    }
}
