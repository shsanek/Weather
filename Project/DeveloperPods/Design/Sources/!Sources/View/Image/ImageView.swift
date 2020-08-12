//
//  ImageView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit
import Utils

public final class ImageView: UIImageView
{

    private var task: DataProvider<UIImage>.DataProviderTask?

    public override var image: UIImage? {
        didSet {
            self.task = nil
        }
    }

    public func setImageProvider(_ imageProvider: DataProvider<UIImage>)
    {
        self.task = imageProvider.fetch(completion: { [weak self] (image) in
            self?.image = image
        })
    }

}
