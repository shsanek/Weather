//
//  IWeatherListScreenUI.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

internal protocol IWeatherListScreenUI: AnyObject
{

    var updateHandler: (() -> Void)? { get set }

    func showEmpty()
    func hideLoadingState()
    func showLoadingState()
    func showErrorState(text: String)
    func showViewModels(_ viewModels: [WeatherViewModel])

}
