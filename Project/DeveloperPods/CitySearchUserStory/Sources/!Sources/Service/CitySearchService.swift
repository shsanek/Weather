//
//  CitySearchService.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import Utils

internal final class CitySearchService: ICitySearchService
{

    internal let dataStorage: IDataStorage

    internal init(config: CitySearchServiceConfig)
    {
        self.dataStorage = CoreDataStorage(modelURL: config.modelURL, dataURL: config.dataURL)
    }

    internal func fetch(with request: CityRequest,
                        completion: @escaping (Result<CityRequestResutl, ModelError>) -> Void)
    {
        var predicate: NSPredicate? = nil
        if !request.text.isEmpty
        {
            predicate = NSPredicate(format: "name CONTAINS[c] %@", argumentArray: [request.text])
        }
        self.dataStorage.fetch(predicate,
                               padge: .make(index: request.padge.index,
                                            count: request.padge.numberOfItems)) { [weak self] (result: [CityRawModel]?) in
                                                self?.didLoad(result,
                                                              with: request,
                                                              completion: completion)
        }
    }

    private func didLoad(_ cityList: [CityRawModel]?,
                         with request: CityRequest,
                         completion: @escaping (Result<CityRequestResutl, ModelError>) -> Void)
    {
        guard let cityList = cityList else
        {
            DispatchQueue.main.async {
                completion(.failure(error: ModelError(code: "not load")))
            }
            return
        }
        let result = cityList.map { (raw) in
            return City(name: raw.name ?? "",
                        latitude: raw.coord_lat,
                        longitude: raw.coord_lon)
        }
        DispatchQueue.main.async {
            completion(.success(data: CityRequestResutl(cityList: result,
                                                        isMore: result.count >= request.padge.numberOfItems)))
        }

    }

}

internal struct CitySearchServiceConfig
{

    internal let modelURL: URL
    internal let dataURL: URL

    internal init()
    {
        guard let modelURL = Bundle.main.url(forResource: "CityList", withExtension: "mom") else
        {
            fatalError("file CityList.mom not found")
        }
        guard let dataURL = Bundle.main.url(forResource: "CityListData", withExtension: "sqllite") else
        {
            fatalError("file CityListData.sqllite not found")
        }
        self.modelURL = modelURL
        self.dataURL = dataURL
    }
    
}
