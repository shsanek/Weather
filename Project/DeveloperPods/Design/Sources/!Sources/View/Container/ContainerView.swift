//
//  ContainerView.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

public protocol IContainerView
{

    associatedtype ContentType: UIView

    var contentView: ContentType { get }

}

public final class ContainerView<ViewType: UIView>: UIView, IContainerView
{

    public let contentView = ViewType()

    public init()
    {
        super.init(frame: .zero)
        self.configure()
    }

    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.configure()
    }

    private func configure()
    {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentView)
        self.backgroundColor = .clear
    }

}
