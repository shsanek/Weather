//
//  NetworkRequestCreater.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import Foundation

public struct NetworkRequestCreater
{

    public static func makeRequest(endPoint: String,
                                   paths: [String],
                                   parameters: [String: String?]) throws -> URLRequest
    {
        guard var url = URL(string: endPoint) else
        {
            throw BaseError.messageError(message: "incorect url \(endPoint)")
        }
        for path in paths
        {
            url.appendPathComponent(path)
        }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else
        {
            throw BaseError.messageError(message: "incorect url \(url)")
        }
        let items = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = items
        guard let resultUrl = components.url else
        {
            throw BaseError.messageError(message: "incorect url \(url)")
        }
        return URLRequest(url: resultUrl)
    }

}
