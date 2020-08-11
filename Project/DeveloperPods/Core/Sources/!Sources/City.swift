//
//  City.swift
//  Design
//
//  Created by Alex Shipin on 11.08.2020.
//

import Foundation

public struct City
{

    public let name: String
    public let latitude: Double
    public let longitude: Double

    public init(name: String,
                latitude: Double,
                longitude: Double)
    {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

}

