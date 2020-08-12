//
//  IDataStorage.swift
//  Utils
//
//  Created by Alex Shipin on 12.08.2020.
//

public protocol IDataStorage
{

    func fetch<DataObjectType: IDataObject>(_ predicate: NSPredicate?,
                                            padge: Padge?,
                                            completion: @escaping ([DataObjectType]?) -> Void)

}
