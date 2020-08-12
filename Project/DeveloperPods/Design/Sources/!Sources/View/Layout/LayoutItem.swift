//
//  LayoutItem.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit

public struct LayoutItem
{

    public let constant: CGFloat
    public let multiplier: CGFloat
    public let relation: NSLayoutConstraint.Relation
    public let priority: UILayoutPriority

    public init(constant: CGFloat)
    {
        self.constant = constant
        self.multiplier = 1.0
        self.relation = .equal
        self.priority = .required
    }

    public init(constant: CGFloat = 0.0,
                multiplier: CGFloat = 1.0,
                relation: NSLayoutConstraint.Relation = .equal,
                priority: UILayoutPriority = .required)
    {
        self.constant = constant
        self.multiplier = multiplier
        self.relation = relation
        self.priority = priority
    }

    internal func invert() -> Self
    {
        return LayoutItem(constant: -self.constant,
                          multiplier: self.multiplier,
                          relation: self.relation,
                          priority: self.priority)
    }

}

