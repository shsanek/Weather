//
//  ICitySearchService.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import Utils

internal protocol ICitySearchService
{

    func fetch(with request: CityRequest,
               completion: @escaping (Result<CityRequestResutl, ModelError>) -> Void)

}

internal struct CityRequest
{

    internal struct Padge
    {

        internal let index: Int
        internal let numberOfItems: Int

    }

    internal let padge: Padge
    internal let text: String
}

internal struct CityRequestResutl
{

    let cityList: [City]
    let isMore: Bool

}

