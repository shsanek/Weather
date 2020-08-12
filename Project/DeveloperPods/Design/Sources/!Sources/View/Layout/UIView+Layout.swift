//
//  IObjectFillerSetting+Layout.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit

internal let identifierLayout = "filler_layout"

extension UIView
{

    internal func removeCustomConstraints()
    {
        self.removeConstraints(self.constraints.filter({ $0.identifier == identifierLayout }))
    }

    public func addSelfConstraint(item: LayoutItem, attribute: NSLayoutConstraint.Attribute)
    {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: item.relation,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: item.multiplier,
                                            constant: item.constant)
        constraint.priority = item.priority
        constraint.identifier = identifierLayout
        self.addConstraint(constraint)
    }

    public func addSuperViewConstraint(item: LayoutItem,
                                       attribute: NSLayoutConstraint.Attribute)
    {
        guard let superview = self.superview else
        {
            return
        }
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: item.relation,
                                            toItem: superview,
                                            attribute: attribute,
                                            multiplier: item.multiplier,
                                            constant: item.constant)
        constraint.priority = item.priority
        constraint.identifier = identifierLayout
        superview.addConstraint(constraint)
    }

}
