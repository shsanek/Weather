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

    private let navigator: INavigator
    private let detailsScreenBuilder: ScreenBuilderWithArgument<WeatherDetailsPresenter, WeatherDetailsUI, WeatherDetailsPresenterConfig>
    private let screenBuilder: ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>
    private var presenter: WeatherListScreenPresenter?

    internal init(navigator: INavigator,
                  builder: ScreenBuilder<WeatherListScreenPresenter, WeatherListScreenUI>,
                  detailsScreenBuilder: ScreenBuilderWithArgument<WeatherDetailsPresenter, WeatherDetailsUI, WeatherDetailsPresenterConfig>)
    {
        self.screenBuilder = builder
        self.navigator = navigator
        self.detailsScreenBuilder = detailsScreenBuilder
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
                self.setHooksPresenter(presenter)
            }
            self.insertScreenHandler?(screen)
        }
        catch
        {
            fatalError("\(error)")
        }
    }

    private func setHooksPresenter(_ presenter: WeatherListScreenPresenter)
    {
        self.presenter = presenter
        presenter.openDetailsHandler = { [weak self] model in
            self?.openDetails(model)
        }
    }

    private func openDetails(_ model: WeatherModel)
    {
        do
        {
            let screen = try self.detailsScreenBuilder.makeScreen(WeatherDetailsPresenterConfig(wather: model))
            self.navigator.show(config: .present(config: ShowPresentConfig(screen: screen)))
        }
        catch
        {
            fatalError("\(error)")
        }
    }

}
