
//
//  RootRouter.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import Utils
import WeatherUserStory
import CitySearchUserStory
import MainScreen

internal final class RootRouter
{

    private let factory: RoutersFactory
    private let navigator: INavigator

    private var weatherListRouter: WeatherListRouter?
    private var citySearchRouter: CitySearchRouter?

    internal init(navigator: INavigator, factory: RoutersFactory)
    {
        self.navigator = navigator
        self.factory = factory
    }

    internal func active()
    {
        let mainScreen = self.factory.mainScreenMaker()
        let weatherListRouter = self.factory.weatherListRouterMaker(self.navigator)
        self.weatherListRouter = weatherListRouter
        weatherListRouter.insertScreenHandler = {
            mainScreen.setMainContent(screen: $0)
        }

        let citySearchRouter = self.factory.citySearchRouterMaker()
        self.citySearchRouter = citySearchRouter
        citySearchRouter.openHandler = { [mainScreen] in
            mainScreen.open()
        }
        citySearchRouter.closeHandler = { [mainScreen] in
            mainScreen.close()
        }
        citySearchRouter.didSelectCityHandler = { [weak weatherListRouter] city in
            weatherListRouter?.didSelectCity(city)
            mainScreen.close()
        }
        citySearchRouter.insertScreenHandler = {
            mainScreen.setBottomContent(screen: $0)
        }

        weatherListRouter.active()
        citySearchRouter.active()
        self.navigator.show(config: .push(config: ShowPushConfig(screen: mainScreen)))
    }


}

extension RootRouter {
    struct RoutersFactory {
        let mainScreenMaker: () -> MainScreen
        let weatherListRouterMaker: (INavigator) -> WeatherListRouter
        let citySearchRouterMaker: () -> CitySearchRouter
    }
}
