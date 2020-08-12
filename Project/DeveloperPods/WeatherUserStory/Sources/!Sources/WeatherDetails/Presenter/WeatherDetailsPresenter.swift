//
//  WeatherDetailsPresenter.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

import Utils

internal final class WeatherDetailsPresenter
{

    private let config: WeatherDetailsPresenterConfig
    private let ui: IWeatherDetailsUI
    private let formatter = DateFormatter.weakDayNameFormatter
    private let imagesService: IImagesService

    internal init(ui: IWeatherDetailsUI,
                  config: WeatherDetailsPresenterConfig,
                  imagesService: IImagesService)
    {
        self.ui = ui
        self.config = config
        self.imagesService = imagesService
        self.buildUI()
    }

    private func buildUI()
    {

        let dayName = self.formatter.string(from: config.wather.day)

        let viewModel = WeatherDetailsViewModel(dayName: dayName,
                                                temperature: "\(config.wather.temperature)",
                                                imageProvider: self.imagesService.imageProvider(config.wather.iconURL))
        self.ui.rebuild(viewModel)
    }

}
