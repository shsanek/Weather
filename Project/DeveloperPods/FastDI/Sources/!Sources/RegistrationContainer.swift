//
//  RegistrationContainer.swift
//  FastDI
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

internal class RegistrationContainer
{

    internal var type: Any.Type
    internal var maker: (_ di: DIContainer, _ args: ArgumentsPool) throws -> Any

    internal init(type: Any.Type, maker: @escaping (_ di: DIContainer, _ args: ArgumentsPool) throws -> Any)
    {
        self.type = type
        self.maker = maker
    }

}
