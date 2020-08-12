//
//  IDataStorageModelRaw.swift
//  Utils
//
//  Created by Alex Shipin on 12.08.2020.
//

public protocol IDataStorageModelRaw
{

    func value(forKey key: String) -> Any?
    func setValue(_ value: Any?, forKey key: String)
}
