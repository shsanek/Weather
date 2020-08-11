//
//  OnecallMethodResultRaw.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

internal struct OnecallMethodResultRaw: Decodable
{

    internal let daily: [DailyRaw]

}

extension OnecallMethodResultRaw
{

    internal struct DailyRaw: Decodable
    {

        internal let date: Double

        internal let temperature: TemperatureRaw

        internal let weather: [TemperatureRaw]

        private enum CodingKeys : String, CodingKey {
            case date = "dt"
            case temperature = "temp"
            case weather
        }

    }

}

extension OnecallMethodResultRaw
{

    internal struct TemperatureRaw: Decodable
    {

        internal let day: Double?

    }

    internal struct Weather: Decodable
    {

        internal let icon: String

    }

}



