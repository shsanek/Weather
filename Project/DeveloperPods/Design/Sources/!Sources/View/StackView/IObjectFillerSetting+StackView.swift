//
//  IViewFiller+StackView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

public typealias Stack<Content> = ViewFiller<StackView<Content>>

extension IObjectFillerSetting where ObjectType: IStackView, Self: IObjectFillerInitable
{

    public init(@StackBuilder contentBuilder: () -> StackViewContent<ObjectType.Content>)
    {
        let content = contentBuilder()
        self = Self().addFillHandler({ (stackView) in
            content.setContent(stackView)
        })
    }

}
