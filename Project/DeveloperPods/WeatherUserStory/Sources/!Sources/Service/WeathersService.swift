//
//  WeathersService.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Utils
import Core

internal final class WeathersService: IWeathersService
{

    private let networkService: INetworkService
    private let configure: WeathersServiceConfigure

    internal init(networkService: INetworkService, configure: WeathersServiceConfigure)
    {
        self.networkService = networkService
        self.configure = configure
    }

    internal func fetchWeathers(with city: City,
                                completion: @escaping (Result<[WeatherModel], ModelError>) -> Void)
    {
        let parameters: [String: String?] =
            [WeathersOnecallMethodKey.appId: self.configure.apiID,
             WeathersOnecallMethodKey.exclude: WeathersOnecallMethodKey.excludeDaysOnlyValue,
             WeathersOnecallMethodKey.units: WeathersOnecallMethodKey.unitsMetricValue,
             WeathersOnecallMethodKey.lat: "\(city.latitude)",
             WeathersOnecallMethodKey.lon: "\(city.longitude)"]
        do
        {
            let request = try NetworkRequestCreater.makeRequest(endPoint: self.configure.endPoint,
                                                                paths: [WeathersOnecallMethodKey.path],
                                                                parameters: parameters)
            self.networkService.fetch(request) { [weak self] in
                self?.didLoadWeathers(raw: $0, completion: completion)
            }
        }
        catch
        {
            completion(.failure(error: .init(code: "\(error)")))
        }
    }

    internal func didLoadWeathers(raw: Result<OnecallMethodResultRaw, NetworkError>,
                                  completion: @escaping (Result<[WeatherModel], ModelError>) -> Void)
    {
        switch raw
        {
        case .failure(let error):
            completion(.failure(error: ModelError(networkError: error)))
        case .success(let data):
            let result = data.daily.map { day -> WeatherModel in
                var imageURL: URL? = nil
                if let icon = day.weather.first?.icon
                {
                    imageURL = URL(string: WeathersOnecallMethodKey.imagesEndPoint)?
                        .appendingPathComponent(icon + WeathersOnecallMethodKey.imageNamePostfix)
                }
                return WeatherModel(day: Date(timeIntervalSince1970: day.date),
                                    temperature: Float(day.temperature.day),
                                    iconURL: imageURL)
            }
            completion(.success(data: result))
        }

    }

}
