//
//  DIError.swift
//  FastDI
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

public enum DIError: Error
{

    public struct TypeErrorInfo
    {
        public let expected: Any.Type
        public let current: Any.Type
    }

    case containerNotFount(type: Any.Type)
    case incorectContainer(info: TypeErrorInfo)
    case incorectArgument(info: TypeErrorInfo)
    case argumentNotFound(type: Any.Type)
    case containerDead

}
