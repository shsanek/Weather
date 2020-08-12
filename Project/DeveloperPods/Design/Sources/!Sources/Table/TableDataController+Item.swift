//
//  TableDataController+Item.swift
//  Design
//
//  Created by Alex Shipin on 11.08.2020.
//

extension TableDataController
{

    public final class Item: Equatable
    {

        internal let cellType: UITableViewCell.Type
        internal let fillerHandler: (UITableViewCell) -> Void
        internal let identifier: String
        internal let actionHandler: (() -> Void)?

        public init<CellType: UITableViewCell>(identifier: String? = nil,
                                               actionHandler: (() -> Void)? = nil,
                                               fillerHandler: @escaping (CellType) -> Void)
        {
            self.cellType = CellType.self
            self.identifier = identifier ?? String(reflecting: CellType.self)
            self.actionHandler = actionHandler
            self.fillerHandler = { unTypeCell in
                guard let cell = unTypeCell as? CellType else
                {
                    assertionFailure("incorect type \(type(of: unTypeCell)) not \(CellType.self)")
                    return
                }
                fillerHandler(cell)
            }
        }

        public static func == (lhs: Item, rhs: Item) -> Bool
        {
            return lhs === rhs
        }

    }

}

extension TableDataController.Item
{

    public convenience init<ViewType: UIView>(actionHandler: (() -> Void)? = nil,
                                              fillerHandler: @escaping (ViewType) -> Void)
    {
        self.init(identifier: nil,
                  actionHandler: actionHandler) { (cell: ContainerTableViewCell<ViewType>) in
            fillerHandler(cell.myContentView)
        }
    }

    public convenience init<FillerType: IViewFiller>(actionHandler: (() -> Void)? = nil,
                                                     fillerBuilder: @escaping () -> FillerType)
    {
        self.init(identifier: nil,
                  actionHandler: actionHandler) { (cell: ContainerTableViewCell<FillerType.ObjectType>) in
                    fillerBuilder().fill(cell.myContentView)
        }
    }

}

