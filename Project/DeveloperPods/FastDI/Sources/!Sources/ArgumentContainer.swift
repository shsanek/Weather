//
//  ArgumentContainer.swift
//  FastDI
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

public func di_arg<Type>(_ argContainer: ArgumentContainer<Type>) -> Type
{
    return argContainer.value
}

public struct ArgumentContainer<Type>: IArgumentContainer
{

    internal var value: Type

    internal init(_ pool: ArgumentsPool) throws
    {
        self.value = try pool.pop()
    }

}

internal protocol IArgumentContainer
{

    init(_ pool: ArgumentsPool) throws

}
