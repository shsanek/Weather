//
//  IObjectFillerSetting+Size.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit

extension IObjectFillerSetting where ObjectType: UIView
{

    public func size(width: LayoutItem, height: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSelfConstraint(item: width, attribute: .width)
            view.addSelfConstraint(item: height, attribute: .height)
        }
    }

    public func width(_ width: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSelfConstraint(item: width, attribute: .width)
        }
    }

    public func height(_ height: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSelfConstraint(item: height, attribute: .height)
        }
    }

    public func size(width: CGFloat, height: CGFloat) -> Self
    {
        return self.size(width: LayoutItem(constant: width), height: LayoutItem(constant: height))
    }

    public func width(_ width: CGFloat) -> Self
    {
        return self.width(LayoutItem(constant: width))
    }

    public func height(_ height: CGFloat) -> Self
    {
        return self.height(LayoutItem(constant: height))
    }

    public func aspectFit(_ item: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            let constraint = NSLayoutConstraint(item: view,
                                                attribute: .width,
                                                relatedBy: item.relation,
                                                toItem: view,
                                                attribute: .height,
                                                multiplier: item.multiplier,
                                                constant: item.constant)
            constraint.priority = item.priority
            constraint.identifier = identifierLayout
            view.addConstraint(constraint)
        }
    }

    public func aspectFit(_ multiplier: CGFloat) -> Self
    {
        return self.aspectFit(LayoutItem(multiplier: multiplier))
    }

}

