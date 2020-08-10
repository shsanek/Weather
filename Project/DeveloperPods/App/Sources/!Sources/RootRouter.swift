
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

    internal var weatherListRouterMaker: () throws -> WeatherListRouter = { throw BaseError.notImplementation }
    internal var citySearchRouterMaker: () throws -> CitySearchRouter = { throw BaseError.notImplementation }

    private let navigator: INavigator

    private var weatherListRouter: WeatherListRouter?
    private var citySearchRouter: CitySearchRouter?

    internal init(navigator: INavigator)
    {
        self.navigator = navigator
    }

    internal func active()
    {
        let mainScreen = MainScreen()
        do
        {
            let weatherListRouter = try self.weatherListRouterMaker()
            self.weatherListRouter = weatherListRouter
            weatherListRouter.insertScreenHandler = {
                mainScreen.setMainContent(screen: $0)
            }

            let citySearchRouter = try self.citySearchRouterMaker()
            self.citySearchRouter = citySearchRouter
            citySearchRouter.insertScreenHandler = {
                mainScreen.setBottomContent(screen: $0)
            }

            weatherListRouter.active()
            citySearchRouter.active()
        }
        catch
        {
            fatalError("\(error)")
        }
        self.navigator.show(config: .push(config: ShowPushConfig(screen: mainScreen)))
    }


}
