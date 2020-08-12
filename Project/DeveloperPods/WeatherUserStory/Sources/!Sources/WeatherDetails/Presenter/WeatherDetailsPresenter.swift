//
//  WeatherDetailsPresenter.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

internal final class WeatherDetailsPresenter
{

    private let config: WeatherDetailsPresenterConfig
    private let ui: IWeatherDetailsUI

    internal init(ui: IWeatherDetailsUI,
                  config: WeatherDetailsPresenterConfig)
    {
        self.ui = ui
        self.config = config
    }

}
