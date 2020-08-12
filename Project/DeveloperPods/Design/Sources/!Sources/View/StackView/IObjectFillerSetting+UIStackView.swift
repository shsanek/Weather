//
//  IViewFiller+UIStackView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

extension IObjectFillerSetting where ObjectType: UIStackView
{

    @discardableResult
    public func setAxis(_ axis: NSLayoutConstraint.Axis) -> Self
    {
        return self.addFillHandler { (stack) in
            stack.axis = axis
        }
    }

    @discardableResult
    public func setDistribution(_ distribution: UIStackView.Distribution) -> Self
    {
        return self.addFillHandler { (stack) in
            stack.distribution = distribution
        }
    }

    @discardableResult
    public func setAlignment(_ alignment: UIStackView.Alignment) -> Self
    {
        return self.addFillHandler { (stack) in
            stack.alignment = alignment
        }
    }

    @discardableResult
    public func setSpacing(_ spacing: CGFloat) -> Self
    {
        return self.addFillHandler { (stack) in
            stack.spacing = spacing
        }
    }

}
