//
//  StorageObject.swift
//  Utils
//
//  Created by Alex Shipin on 12.08.2020.
//

open class StorageObject
{

    private let model: IDataStorageModelRaw

    required public init(_ model: IDataStorageModelRaw)
    {
        self.model = model
        Mirror(reflecting: self).children.forEach { (child) in
            if let storageLinked = child.value as? IStorageLinked
            {
                var name = child.label ?? ""
                if name.first == "_"
                {
                    name.removeFirst()
                }
                storageLinked.getHandler = {
                    return model.value(forKey: name) as Any
                }
                storageLinked.setHandler = { value in
                    model.setValue(value, forKey: name)
                }
            }
        }
    }

}
