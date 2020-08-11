//
//  IWeathersService.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Utils
import Core

internal protocol IWeathersService
{

    func fetchWeathers(with city: City,
                       completion: @escaping (Result<[WeatherModel], ModelError>) -> Void)

}
