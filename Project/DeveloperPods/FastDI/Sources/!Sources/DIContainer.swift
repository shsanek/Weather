//
//  DIContainer.swift
//  FastDI
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

public final class DIContainer
{

    private var containers = [RegistrationContainer]()

    public init()
    {
    }

    public func resolve<Type>(_ args: Any...) throws -> Type
    {
        guard let container = self.containers.first(where: { $0.type == Type.self }) else
        {
            throw DIError.containerNotFount(type: Type.self)
        }
        let value = try container.maker(self, ArgumentsPool(args))
        guard let result = value as? Type else
        {
            throw DIError.incorectContainer(info: DIError.TypeErrorInfo(expected: Type.self,
                                                                        current: type(of: value)))
        }
        return result
    }

    private func register<Type>(_ maker: @escaping (_ di: DIContainer, _ args: ArgumentsPool) throws -> Type) -> RegistrationControll<Type>
    {
        let container = RegistrationContainer(type: Type.self, maker: { try maker($0, $1) })
        let controll = RegistrationControll<Type>(container: container)
        self.containers.append(container)
        return controll
    }

    private func fetchValue<Type>(argumentsPool: ArgumentsPool) throws -> Type
    {
        if let argumentType = Type.self as? IArgumentContainer.Type
        {
            let value = try argumentType.init(argumentsPool)
            guard let result = value as? Type else
            {
                throw DIError.incorectArgument(info: DIError.TypeErrorInfo(expected: Type.self,
                                                                           current: type(of: value)))
            }
            return result
        }
        else
        {
            return try self.resolve()
        }
    }

}

extension DIContainer
{

    @discardableResult
    public func register<Type>(_ maker: @escaping (()) -> Type) -> RegistrationControll<Type>
    {
        self.register({ _, _ in maker(()) })
    }

    @discardableResult
    public func register<Type, ARG1>(_ maker: @escaping (ARG1) -> Type) -> RegistrationControll<Type>
    {
        self.register { di, argumentsPool in
            return maker(try di.fetchValue(argumentsPool: argumentsPool))
        }
    }

    @discardableResult
    public func register<Type, ARG1, ARG2>(_ maker: @escaping ((ARG1, ARG2)) -> Type) -> RegistrationControll<Type>
    {
        self.register { di, argumentsPool in
            return maker((try di.fetchValue(argumentsPool: argumentsPool),
                         try di.fetchValue(argumentsPool: argumentsPool)))
        }
    }

    @discardableResult
    public func register<Type, ARG1, ARG2, ARG3>(_ maker: @escaping ((ARG1, ARG2, ARG3)) -> Type) -> RegistrationControll<Type>
    {
        self.register { di, argumentsPool in
            return maker((try di.fetchValue(argumentsPool: argumentsPool),
                         try di.fetchValue(argumentsPool: argumentsPool),
                         try di.fetchValue(argumentsPool: argumentsPool)))
        }
    }

}
