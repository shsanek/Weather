//
//  WeatherListScreenPresenter.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import Utils

internal final class WeatherListScreenPresenter
{

    internal var city: City? {
        didSet {
            self.load()
        }
    }

    internal var openDetailsHandler: ((WeatherModel) -> Void)?

    private let ui: IWeatherListScreenUI
    private let weathersService: IWeathersService
    private let formatter = DateFormatter.weakDayNameFormatter
    private let imagesService: IImagesService

    internal init(ui: IWeatherListScreenUI,
                  weathersService: IWeathersService,
                  imagesService: IImagesService)
    {
        self.ui = ui
        self.weathersService = weathersService
        self.imagesService = imagesService
        self.load()
        self.ui.updateHandler = { [weak self] in
            self?.load()
        }
    }

    private func load()
    {
        guard let city = self.city else
        {
            self.ui.showEmpty()
            return
        }
        self.ui.showLoadingState()
        self.weathersService.fetchWeathers(with: city) { [weak self] (result) in
            self?.didLoad(result)
            self?.ui.hideLoadingState()
        }
    }

    private func didLoad(_ result: Result<[WeatherModel], ModelError>)
    {
        switch result
        {
        case .success(let data):
            self.showWeathers(data)
        case .failure(let error):
            self.showError(error)
        }
    }

    private func showError(_ error: ModelError)
    {
        self.ui.showErrorState(text: error.code)
    }

    private func showWeathers(_ weathers: [WeatherModel])
    {
        self.ui.showViewModels(weathers.map(self.createViewModel))
    }

    private func createViewModel(_ model: WeatherModel) -> WeatherViewModel
    {
        let dayName = self.formatter.string(from: model.day)
        return WeatherViewModel(imageProvider: self.imagesService.imageProvider(model.iconURL),
                                temperature: "\(model.temperature)",
                                dayName: dayName) { [weak self] in
                                    self?.openDetailsHandler?(model)
        }
    }

}
