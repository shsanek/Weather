//
//  IDataObject.swift
//  Utils
//
//  Created by Alex Shipin on 12.08.2020.
//

public protocol IDataObject: StorageObject
{
    static var identifier: String { get }
}

