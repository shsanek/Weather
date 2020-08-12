//
//  StackViewContent.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

public struct StackViewContent<ItemsType>
{

    public struct ContentItem
    {

        internal let makeContentHandler: () -> UIView
        internal let fillHandler: ((_ view: UIView) -> Void)

        private init<Filler: IViewFiller>(filler: Filler)
        {
            self.makeContentHandler = { Filler.ObjectType.init() }
            self.fillHandler = { (view) in
                guard let fillerView = view as? Filler.ObjectType else
                {
                    assertionFailure("\(view) is not \(Filler.ObjectType.self)")
                    return
                }
                filler.fill(fillerView)
            }
        }

        internal static func make<Filler: IViewFiller>(_ filler: Filler) -> ContentItem
        {
            return ContentItem(filler: filler)
        }

    }

    internal let contentItems: [ContentItem]

    internal init(_ contentItems: [ContentItem])
    {
        self.contentItems = contentItems
    }

    internal func setContent<StackViewType: IStackView>(_ stackView: StackViewType)
    {
        if stackView.arrangedSubviews.count == 0
        {
            self.configure(stackView)
        }
        guard stackView.arrangedSubviews.count == self.contentItems.count else
        {
            assertionFailure("arrangedSubviews in StackView")
            return
        }
        for i in 0..<self.contentItems.count
        {
            self.contentItems[i].fillHandler(stackView.arrangedSubviews[i])
        }
    }

    private func configure<StackViewType: IStackView>(_ stackView: StackViewType)
    {
        for item in self.contentItems
        {
            stackView.addArrangedSubview(item.makeContentHandler())
        }
    }

}
