//
//  DataProvider.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

public final class DataProvider<DataType>
{

    private let requestHandler: (_ completion: @escaping (DataType?) -> Void) -> Void

    public init(requestHandler: @escaping (_ completion: @escaping (DataType?) -> Void) -> Void)
    {
        self.requestHandler = requestHandler
    }

    public func fetch(completion: @escaping (DataType?) -> Void) -> DataProviderTask
    {
        return DataProviderTask(requestHandler: self.requestHandler, completion: completion)
    }

}

extension DataProvider
{

    public final class DataProviderTask
    {

        fileprivate init(requestHandler: @escaping (_ completion: @escaping (DataType?) -> Void) -> Void,
                      completion: @escaping (DataType?) -> Void)
        {
            requestHandler({ [weak self] (data) in
                if self != nil
                {
                    completion(data)
                }
            })
        }
    }

}

