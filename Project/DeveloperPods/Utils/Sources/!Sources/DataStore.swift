//
//  DataStore.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import CoreData

public final class DataStore
{

    private let modelURL: URL
    private let dataURL: URL

    public struct Padge
    {

        internal let index: Int
        internal let count: Int

        public static func make(index: Int, count: Int) -> Padge
        {
            return Padge(index: index, count: count)
        }

    }

    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return urls[urls.count-1]
    }()

    private lazy var persisentStoreCordinator: NSPersistentStoreCoordinator = {

        let url = self.modelURL
        let managedObjectModel = NSManagedObjectModel(contentsOf: url)!
        let persisentStoreCordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let sqlLiteUrl = self.dataURL
        try! persisentStoreCordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                         configurationName: nil,
                                                         at: sqlLiteUrl,
                                                         options: nil)
        return persisentStoreCordinator
    }()

    private lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persisentStoreCordinator
        return managedObjectContext
    }()

    public init(modelURL: URL, dataURL: URL)
    {
        self.modelURL = modelURL
        self.dataURL = dataURL
    }

    public func fetch<DataObjectType: DataObject>(_ predicate: NSPredicate? = nil,
                                                  padge: Padge? = nil,
                                                  completion: @escaping ([DataObjectType]?) -> Void)
    {
        let request = NSFetchRequest<NSManagedObject>(entityName: DataObjectType.identifier)
        request.predicate = predicate
        if let padge = padge
        {
            request.fetchLimit = padge.count
            request.fetchOffset = padge.count * padge.index
        }
        self.managedObjectContext.perform {
            let result = try? self.managedObjectContext.fetch(request)
            completion(result?.map(DataObjectType.init))
        }
    }


}

public protocol DataObject: StorageObject
{
    static var identifier: String { get }
}

// Короче все что ниже это я в трех соснах не разобрался
// как связать тот обьект который я хочу с ентиту из модели кордаты
// чето не хочет или я туплю ну решил написать обертку в целом она
// на правильную модельку переписывается
internal protocol IStorageLinked: AnyObject
{

    var getHandler: (() -> Any)? { get set }
    var setHandler: ((_ value: Any) -> Void)? { get set }

}

open class StorageObject
{

    private let model: NSManagedObject

    required public init(_ model: NSManagedObject)
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

@propertyWrapper
public class StorageLinked<Value>: IStorageLinked
{

    internal var getHandler: (() -> Any)?
    internal var setHandler: ((Any) -> Void)?


    public var wrappedValue: Value {
        get {
            return self.getHandler?() as! Value
        }
        set {
            self.setHandler?(newValue)
        }
    }

    public init()
    {
    }

}
