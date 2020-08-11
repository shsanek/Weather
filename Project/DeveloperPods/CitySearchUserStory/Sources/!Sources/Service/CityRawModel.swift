//
//  DataStore.swift
//  CitySearchUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

import CoreData
import Utils

internal class CityRawModel: StorageObject, DataObject
{

    internal static var identifier: String {
        return "City"
    }
    @StorageLinked public var coord_lat: Double
    @StorageLinked public var coord_lon: Double
    @StorageLinked public var id: Int64
    @StorageLinked public var name: String?

}


