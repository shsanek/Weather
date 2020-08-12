//
//  IObjectFiller.swift
//  CitySearchUserStory
//
//  Created by Alex Shipin on 12.08.2020.
//

public protocol IObjectFiller
{

    associatedtype ObjectType

    func fill(_ object: ObjectType)

}

public protocol IObjectFillerSetting
{

    associatedtype ObjectType


    func addFillHandler(_ handler: @escaping (ObjectType) -> Void) -> Self

}

public protocol IObjectFillerInitable
{

    init()

}
