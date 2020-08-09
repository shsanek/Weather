//
//  RegistrationControll.swift
//  FastDI
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

public struct RegistrationControll<Type>
{

    private let container: RegistrationContainer

    internal init(container: RegistrationContainer)
    {
        self.container = container
    }

    @discardableResult
    public func `as`<NewType>(_ type: NewType.Type) -> RegistrationControll<NewType>
    {
        self.container.type = type
        return RegistrationControll<NewType>(container: self.container)
    }

    @discardableResult
    private func injection<PropertyType>(_ keyPath: WritableKeyPath<Type, PropertyType>,
                                         propertyValue: @escaping (_ di: DIContainer) throws -> PropertyType) -> RegistrationControll
    {
        let maker = self.container.maker
        self.container.maker = { (_ di: DIContainer, _ args: ArgumentsPool) in
            let value = try maker(di, args)
            guard var result = value as? Type else
            {
                throw DIError.incorectContainer(info: DIError.TypeErrorInfo(expected: Type.self,
                                                                            current: type(of: value)))
            }
            result[keyPath: keyPath] = try propertyValue(di)
            return result
        }
        return self
    }

    @discardableResult
    public func injection<ResultType>(_ keyPath: WritableKeyPath<Type, (() throws -> ResultType)>) -> RegistrationControll
    {
        return self.injection(keyPath) { di in
            weak var di = di
            return {
                guard let di = di else
                {
                    throw DIError.containerDead
                }
                return try di.resolve()
            }
        }
    }

    @discardableResult
    public func injection<ARG1, ResultType>(_ keyPath: WritableKeyPath<Type, ((ARG1) throws -> ResultType)>) -> RegistrationControll
    {
        return self.injection(keyPath) { di in
            weak var di = di
            return {
                guard let di = di else
                {
                    throw DIError.containerDead
                }
                return try di.resolve($0)
            }
        }
    }

    @discardableResult
    public func injection<ARG1, ARG2, ResultType>(_ keyPath: WritableKeyPath<Type, ((ARG1, ARG2) throws -> ResultType)>) -> RegistrationControll
    {
        return self.injection(keyPath) { di in
            weak var di = di
            return {
                guard let di = di else
                {
                    throw DIError.containerDead
                }
                return try di.resolve($0, $1)
            }
        }
    }

    @discardableResult
    public func injection<ARG1, ARG2, ARG3, ResultType>(_ keyPath: WritableKeyPath<Type, ((ARG1, ARG2, ARG3) throws -> ResultType)>) -> RegistrationControll
    {
        return self.injection(keyPath) { di in
            weak var di = di
            return {
                guard let di = di else
                {
                    throw DIError.containerDead
                }
                return try di.resolve($0, $1, $2)
            }
        }
    }

}
