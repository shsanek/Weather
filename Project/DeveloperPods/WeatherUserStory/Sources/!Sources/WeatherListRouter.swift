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
    private var presenter: WeatherListScreenPresenter?

    internal init(builder: ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>)
    {
        self.screenBuilder = builder
    }

    public func didSelectCity(_ city: City)
    {
        self.presenter?.city = city
    }

    public func active()
    {
        do
        {
            let screen = try self.screenBuilder.makeScreen { presenter in
                self.presenter = presenter
            }
            self.insertScreenHandler?(screen)
        }
        catch
        {
            fatalError("\(error)")
        }
    }

}
