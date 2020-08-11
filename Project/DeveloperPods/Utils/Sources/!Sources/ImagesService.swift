//
//  File.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import Foundation
import UIKit

public protocol IImagesService
{

    func imageProvider(_ url: URL?) -> DataProvider<UIImage>
}

public final class ImagesService: IImagesService
{

    internal let session: URLSession
    internal var images = [URL: UIImage]()

    public init(session: URLSession)
    {
        self.session = session
    }

    public func imageProvider(_ url: URL?) -> DataProvider<UIImage>
    {
        guard let url = url else
        {
            return DataProvider { (completion) in
                completion(nil)
            }
        }
        if let image = self.images[url]
        {
            return DataProvider { (completion) in
                completion(image)
            }
        }
        return DataProvider { [session, weak self] (completion) in
            session.dataTask(with: url) { (data, _, _) in
                if let data = data, let image = UIImage(data: data)
                {
                    DispatchQueue.main.async {
                        self?.images[url] = image
                        completion(image)
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }

}
