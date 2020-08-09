//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Alex Shipin on 06.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

import XCTest
@testable import FastDI

internal class DIContainerTests: XCTestCase
{

    internal func test01() throws
    {
        print("test01--------------------")
        let container = DIContainer()
        container.register(A.init)
        _ = try container.resolve() as A
    }

    internal func test02() throws
    {
        print("test02--------------------")
        let container = DIContainer()
        container.register(A.init)
        container.register(B.init)

        _ = try container.resolve() as B
    }

    internal func test03() throws
    {
        print("test03--------------------")
        let container = DIContainer()
        container.register {
            B(a: di_arg($0))
        }

        _ = try container.resolve(A()) as B
    }

    internal func test04() throws
    {
        print("test04--------------------")
        let container = DIContainer()

        container.register(A.init)
        container.register(B.init)
            .as(IB.self)

        _ = try container.resolve(A()) as IB
    }

    internal func test05() throws
    {
        print("test05--------------------")
        let container = DIContainer()

        container.register(A.init)
        container.register(B.init)
            .as(IB.self)
        container.register(C.init)
            .injection(\.bMaker)

        let c: C = try container.resolve()
        _ = try c.bMaker()
    }

    internal func test06() throws
    {
        print("test0--------------------")
        let container = DIContainer()

        container.register {
            B(a: di_arg($0))
        }
            .as(IB.self)
        container.register(D.init)
            .injection(\.bMaker)

        let d: D = try container.resolve()
        _ = try d.bMaker(A())
    }

}


fileprivate final class A { }

fileprivate protocol IB
{
}

fileprivate final class B: IB
{

    internal init(a: A) { }

}

fileprivate struct NotImplementationError: Error
{

}

fileprivate final class C
{

    internal var bMaker: (() throws -> IB) = { throw NotImplementationError() }

    internal init()
    {
    }

}

fileprivate final class D
{

    internal var bMaker: ((A) throws -> IB) = { _ in throw NotImplementationError() }

    internal init()
    {
    }

}

