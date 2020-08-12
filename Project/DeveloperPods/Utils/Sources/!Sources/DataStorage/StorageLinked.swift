//
//  StorageLinked.swift
//  Utils
//
//  Created by Alex Shipin on 12.08.2020.
//

@propertyWrapper
public class StorageLinked<Value>: IStorageLinked
{

    internal var getHandler: (() -> Any)?
    internal var setHandler: ((Any) -> Void)?


    public var wrappedValue: Value {
        get {
            let notTypeValue = self.getHandler?()
            guard let value = notTypeValue as? Value else
            {
                fatalError("\(type(of: notTypeValue)) is not \(Value.self)")
            }
            return value
        }
        set {
            self.setHandler?(newValue)
        }
    }

    public init()
    {
    }

}

internal protocol IStorageLinked: AnyObject
{

    var getHandler: (() -> Any)? { get set }
    var setHandler: ((_ value: Any) -> Void)? { get set }

}
