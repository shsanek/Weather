//
//  CitySearchRouter.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core

public final class CitySearchRouter
{

    public var didSelectCityHandler: ((_ city: City) -> Void)?
    public var openHandler: (() -> Void)?
    public var closeHandler: (() -> Void)?
    public var insertScreenHandler: ((IScreen) -> Void)?

    private let screenBuilder: ScreenBuilder<CitySearchScreenPresenter, CitySearchScreenUI>

    internal init(builder: ScreenBuilder<CitySearchScreenPresenter, CitySearchScreenUI>)
    {
        self.screenBuilder = builder
    }

    public func active()
    {
        let screen = self.screenBuilder.makeScreen { (presenter) in
            self.setHooks(presenter)
        }
        self.insertScreenHandler?(screen)
    }

    private func setHooks(_ presenter: CitySearchScreenPresenter)
    {
        presenter.closeHandler = { [weak self] in
            self?.closeHandler?()
        }
        presenter.didSelectCityHandler = { [weak self] city in
            self?.didSelectCityHandler?(city)
        }
        presenter.openHandler = { [weak self] in
            self?.openHandler?()
        }
    }

}
