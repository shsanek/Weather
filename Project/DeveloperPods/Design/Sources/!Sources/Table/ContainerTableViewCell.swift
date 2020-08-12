//
//  ContainerTableViewCell.swift
//  TurboKit
//
//  Created by Alex Shipin on 17.08.2019.
//

public class ContainerTableViewCell<ContentType: UIView>: UITableViewCell
{

    public let myContentView: ContentType

    public init(reuseIdentifier: String, _ contentMaker: () -> ContentType)
    {
        self.myContentView = contentMaker()
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.configure()
    }

    internal override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        self.myContentView = ContentType()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }

    internal required init?(coder: NSCoder)
    {
        self.myContentView = ContentType()
        super.init(coder: coder)
        self.configure()
    }

    internal func configure()
    {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.myContentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.removeFromSuperview()
        self.addSubview(self.myContentView)
        let bottom = self.bottomAnchor.constraint(equalTo: self.myContentView.bottomAnchor)
        bottom.priority = UILayoutPriority(rawValue: 750)
        self.addConstraints([self.topAnchor.constraint(equalTo: self.myContentView.topAnchor),
                             bottom,
                             self.leftAnchor.constraint(equalTo: self.myContentView.leftAnchor),
                             self.rightAnchor.constraint(equalTo: self.myContentView.rightAnchor)])
    }

}
