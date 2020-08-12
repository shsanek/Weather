//
//  IObjectFillerSetting+ImageView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import Utils

extension IObjectFillerSetting where ObjectType: ImageView
{

    public func imageProvider(_ provider: DataProvider<UIImage>) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.setImageProvider(provider)
        }
    }

}

extension IObjectFillerSetting where ObjectType: ImageView, Self: IObjectFillerInitable
{

    public init(_ provider: DataProvider<UIImage>)
    {
        self = Self.init().imageProvider(provider)
    }

}

