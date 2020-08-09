//
//  ArgumentsPool.swift
//  FastDI
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

internal final class ArgumentsPool
{

    private var arguments: [Any]

    internal init(_ arguments: [Any])
    {
        self.arguments = arguments
    }

    internal func pop<Type>() throws -> Type
    {
        guard self.arguments.count > 0 else
        {
            throw DIError.argumentNotFound(type: Type.self)
        }
        let value = self.arguments.removeFirst()
        guard let result = value as? Type else
        {
            throw DIError.incorectArgument(info: DIError.TypeErrorInfo(expected: Type.self,
                                                                       current: type(of: value)))
        }
        return result
    }
}
