//
//  IStackView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

public protocol IStackView: UIStackView
{

    associatedtype Content

    func setContent(_ contetn: StackViewContent<Content>)

}

public final class StackView<Content>: UIStackView, IStackView
{

    internal init()
    {
        super.init(frame: .zero)
    }

    public override init(frame: CGRect)
    {
        super.init(frame: .zero)
    }

    public init(@StackBuilder builder: () -> StackViewContent<Content>)
    {
        let content = builder()
        super.init(frame: .zero)
        content.setContent(self)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setContent(_ content: StackViewContent<Content>)
    {
        content.setContent(self)
    }

}
