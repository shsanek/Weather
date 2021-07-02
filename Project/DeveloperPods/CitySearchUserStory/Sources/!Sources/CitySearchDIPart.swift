//
//  CitySearchDIPart.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import DIGreatness
import Core

public struct CitySearchDIPart: DIPart
{
    public init() { }
    
    public func registration(_ registrator: DIRegistrator) throws {
        try registrator.register {
            CitySearchScreenPresenter(ui: diArg($0) as CitySearchScreenUI,
                                      citySearchService: $1)
        }
        try registrator.register(CitySearchServiceConfig.init)
        try registrator.register(CitySearchScreenUI.init)
        try registrator.register(CitySearchService.init)
            .map { $0 as ICitySearchService }
        try registrator.register(CitySearchRouter.init)
        try registrator.register(ScreenBuilder<CitySearchScreenPresenter, CitySearchScreenUI>.init)
    }

}
