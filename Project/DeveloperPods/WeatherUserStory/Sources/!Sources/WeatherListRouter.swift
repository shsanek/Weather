//
//  WeatherListRouter.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core

public final class WeatherListRouter
{

    public var insertScreenHandler: ((IScreen) -> Void)?

    private let screenBuilder: ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>

    internal init(builder: ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>)
    {
        self.screenBuilder = builder
    }

    public func active()
    {
        do
        {
            let screen = try self.screenBuilder.makeScreen()
            self.insertScreenHandler?(screen)
        }
        catch
        {
            fatalError("\(error)")
        }
    }

}
