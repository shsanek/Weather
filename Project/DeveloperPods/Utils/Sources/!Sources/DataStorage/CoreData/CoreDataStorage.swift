//
//  DataStore.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import CoreData

public final class CoreDataStorage: IDataStorage
{

    private let modelURL: URL
    private let dataURL: URL

    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return urls[urls.count-1]
    }()

    private lazy var persisentStoreCordinator: NSPersistentStoreCoordinator = {

        let url = self.modelURL
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else
        {
            fatalError("not create NSManagedObjectModel with url \(url)")
        }
        let persisentStoreCordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let sqlLiteUrl = self.dataURL
        do
        {
            try persisentStoreCordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                            configurationName: nil,
                                                            at: sqlLiteUrl,
                                                            options: nil)
        }
        catch
        {
            fatalError("\(error)")
        }
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

    public func fetch<DataObjectType: IDataObject>(_ predicate: NSPredicate? = nil,
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
