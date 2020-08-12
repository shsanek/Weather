//
//  NetworkService.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import Foundation

public protocol INetworkService
{

    func fetch<ResultType: Decodable>(_ request: URLRequest,
                                      completion: @escaping (Result<ResultType, NetworkError>) -> Void)

}

public final class NetworkService: INetworkService
{

    internal let session: URLSession

    public init(session: URLSession)
    {
        self.session = session
    }

    public func fetch<ResultType: Decodable>(_ request: URLRequest,
                                             completion: @escaping (Result<ResultType, NetworkError>) -> Void)
    {

        /// ошибки лучше по нормальному обрабытвать но для начала сойдет
        let task = self.session.dataTask(with: request) { (data, respons, error) in
            if let error = error
            {
                DispatchQueue.main.async {
                    completion(.failure(error: NetworkError(code: (error as NSError).code)))
                }
                return
            }
            guard let data = data else
            {
                DispatchQueue.main.async {
                    completion(.failure(error: NetworkError(code: -01)))
                }
                return
            }
            do
            {
                let result = try JSONDecoder().decode(ResultType.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(data: result))
                }
            }
            catch
            {
                print("\(error)")
                DispatchQueue.main.async {
                    completion(.failure(error: NetworkError(code: -02)))
                }
            }
        }
        task.resume()
    }

}
