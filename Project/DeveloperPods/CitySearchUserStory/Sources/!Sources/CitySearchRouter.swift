//
//  CitySearchRouter.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core

public final class CitySearchRouter
{

    public var insertScreenHandler: ((IScreen) -> Void)?

    private let screenBuilder: ScreenBuilder<CitySearchScreenPresenter, CitySearchScreenUI>

    internal init(builder: ScreenBuilder<CitySearchScreenPresenter, CitySearchScreenUI>)
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
