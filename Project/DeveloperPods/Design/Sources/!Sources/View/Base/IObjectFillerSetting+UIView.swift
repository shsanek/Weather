//
//  IObjectFillerSetting+UIView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit

public typealias View = ViewFiller<UIView>
public typealias Image = ViewFiller<ImageView>
public typealias Label = ViewFiller<UILabel>

extension IObjectFillerSetting where ObjectType: UIView
{

    public func backgroundColor(_ color: UIColor) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.backgroundColor = color
        }
    }

    public func cornerRadius(_ value: CGFloat) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.layer.cornerRadius = value
        }
    }

    public func borderColor(_ color: UIColor) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.layer.borderColor = color.cgColor
        }
    }

    public func borderWidth(_ value: CGFloat) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.layer.borderWidth = value
        }
    }

    public func clipsToBounds(_ value: Bool) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.clipsToBounds = value
        }
    }

    public func tintColor(_ color: UIColor) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.tintColor = color
        }
    }

}


extension IObjectFillerSetting where ObjectType: UILabel
{

    public func text(_ text: String?) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.text = text
        }
    }

    public func textColor(_ color: UIColor) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.textColor = color
        }
    }

    public func font(_ font: UIFont) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.font = font
        }
    }

    public func attributedText(_ attributedText: NSAttributedString?) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.attributedText = attributedText
        }
    }

    public func textAlignment(_ textAlignment: NSTextAlignment) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.textAlignment = textAlignment
        }
    }

}

extension IObjectFillerSetting where ObjectType: UIImageView
{

    public func image(_ image: UIImage?) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.image = image
        }
    }

}

extension IObjectFillerSetting where ObjectType: UILabel, Self: IObjectFillerInitable
{

    public init(_ text: String?)
    {
        self = Self.init().text(text)
    }

    public init(_ attributedText: NSAttributedString?)
    {
        self = Self.init().attributedText(attributedText)
    }

}

extension IObjectFillerSetting where ObjectType: UIImageView, Self: IObjectFillerInitable
{

    public init(_ image: UIImage?)
    {
        self = Self.init().image(image)
    }

}
