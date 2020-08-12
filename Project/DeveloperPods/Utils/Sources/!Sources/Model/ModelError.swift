//
//  ModelError.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

public struct ModelError
{

    public let code: String

    public init(code: String)
    {
        self.code = code
    }

}

extension ModelError
{

    public init(networkError: NetworkError)
    {
        self.init(code: "NETWORK:\(networkError.code)")
    }

}
