//
//  IObjectFillerSetting+Position.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit

extension IObjectFillerSetting where ObjectType: UIView
{

    public func centerX(_ x: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSuperViewConstraint(item: x, attribute: .centerX)
        }
    }

    public func centerY(_ y: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSuperViewConstraint(item: y, attribute: .centerY)
        }
    }

    public func center(x: LayoutItem, y: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSuperViewConstraint(item: y, attribute: .centerY)
            view.addSuperViewConstraint(item: x, attribute: .centerX)
        }
    }

    public func centerX(_ x: CGFloat = 0.0) -> Self
    {
        return self.centerX(LayoutItem(constant: x))
    }

    public func centerY(_ y: CGFloat = 0.0) -> Self
    {
        return self.centerY(LayoutItem(constant: y))

    }

    public func center(x: CGFloat = 0.0, y: CGFloat = 0.0) -> Self
    {
        return self.center(x: LayoutItem(constant: x), y: LayoutItem(constant: y))
    }

    public func horizontalOfsset(left: LayoutItem, right: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSuperViewConstraint(item: left, attribute: .left)
            view.addSuperViewConstraint(item: right.invert(), attribute: .right)
        }
    }

    public func verticalOfsset(top: LayoutItem, bottom: LayoutItem) -> Self
    {
        return self.addFillHandler { (view) in
            view.addSuperViewConstraint(item: top, attribute: .top)
            view.addSuperViewConstraint(item: bottom.invert(), attribute: .bottom)
        }
    }

    public func horizontalOfsset(left: CGFloat = 0.0, right: CGFloat = 0.0) -> Self
    {
        return self.horizontalOfsset(left: LayoutItem(constant: left), right: LayoutItem(constant: right))

    }

    public func verticalOfsset(top: CGFloat = 0.0, bottom: CGFloat = 0.0) -> Self
    {
        return self.verticalOfsset(top: LayoutItem(constant: top), bottom: LayoutItem(constant: bottom))
    }

    public func freeOffset(top: LayoutItem? = nil,
                           bottom: LayoutItem? = nil,
                           left: LayoutItem? = nil,
                           right: LayoutItem? = nil) -> Self
    {
        return self.addFillHandler { (view) in
            left.flatMap { view.addSuperViewConstraint(item: $0, attribute: .left) }
            right.flatMap { view.addSuperViewConstraint(item: $0.invert(), attribute: .right) }
            top.flatMap { view.addSuperViewConstraint(item: $0, attribute: .top) }
            bottom.flatMap { view.addSuperViewConstraint(item: $0.invert(), attribute: .bottom) }
        }
    }

    public func freeOffset(top: CGFloat? = nil,
                           bottom: CGFloat? = nil,
                           left: CGFloat? = nil,
                           right: CGFloat? = nil) -> Self
    {
        return self.freeOffset(top: top.flatMap(LayoutItem.init(constant:)),
                               bottom: bottom.flatMap(LayoutItem.init(constant:)),
                               left: left.flatMap(LayoutItem.init(constant:)),
                               right: right.flatMap(LayoutItem.init(constant:)))
    }

    public func offset(top: CGFloat = 0.0,
                       bottom: CGFloat = 0.0,
                       left: CGFloat = 0.0,
                       right: CGFloat = 0.0) -> Self
    {
        return self.freeOffset(top: top,
                               bottom: bottom,
                               left: left,
                               right: right)
    }

    public func insets(insets : UIEdgeInsets) -> Self
    {
        return self.offset(top: insets.top, bottom: insets.bottom, left: insets.left, right: insets.right)
    }

}
