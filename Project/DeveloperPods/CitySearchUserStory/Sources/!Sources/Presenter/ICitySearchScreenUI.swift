//
//  ICitySearchScreenUI.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

internal protocol ICitySearchScreenUI: AnyObject
{

    var updateSearchStringHandler: ((String) -> Void)? { get set }
    var openHandler: (() -> Void)? { get set }

    func appendViewModels(_ viewModels: [CityViewModel], nextPadgeRequest: (() -> Void)?)
    func clear()
    func resetSearch()

}
