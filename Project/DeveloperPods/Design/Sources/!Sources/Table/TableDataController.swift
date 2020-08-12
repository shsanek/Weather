//
//  TableDataController.swift
//  Utils
//
//  Created by Alex Shipin on 11.08.2020.
//

import UIKit


public final class TableDataController: NSObject, UITableViewDataSource, UITableViewDelegate
{

    public let tableView: UITableView
    public var items = [Item]() {
        didSet {
            self.update()
        }
    }

    internal var registedIdentifiers = Set<String>()

    public init(_ tableView: UITableView = UITableView())
    {
        self.tableView = tableView
        super.init()
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    internal func update()
    {
        self.tableView.reloadData()
    }

    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let item = self.items[indexPath.row]
        if !self.registedIdentifiers.contains(item.identifier)
        {
            self.tableView.register(item.cellType, forCellReuseIdentifier: item.identifier)
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        item.fillerHandler(cell)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.items[indexPath.row].actionHandler?()
    }

    public func removeItem(_ item: Item?)
    {
        if let item = item
        {
            self.items.removeAll(where: { $0 == item })
        }
    }

    public func removeItems(_ items: [Item]?)
    {
        if let items = items
        {
            self.items.removeAll(where: { items.contains($0) })
        }
    }

}

extension TableDataController
{

    @discardableResult
    public func insertItem<ViewType: UIView>(at index: Int,
                                             actionHandler: (() -> Void)? = nil,
                                             fillerHandler: @escaping (ViewType) -> Void) -> Item
    {
        let item = Item(actionHandler: actionHandler, fillerHandler: fillerHandler)
        self.items.insert(item, at: index)
        return item
    }

    @discardableResult
    public func addItem<ViewType: UIView>(actionHandler: (() -> Void)? = nil,
                                          fillerHandler: @escaping (ViewType) -> Void) -> Item
    {
        let item = Item(actionHandler: actionHandler, fillerHandler: fillerHandler)
        self.items.append(item)
        return item
    }

}

extension TableDataController
{

    @discardableResult
    public func insertItem<FillerType: IViewFiller>(at index: Int,
                                                    actionHandler: (() -> Void)? = nil,
                                                    fillerBuilder: @escaping () -> FillerType) -> Item
    {
        let item = Item(actionHandler: actionHandler) {
            fillerBuilder().fill($0)
        }
        self.items.insert(item, at: index)
        return item
    }

    @discardableResult
    public func addItem<FillerType: IViewFiller>(actionHandler: (() -> Void)? = nil,
                                                 fillerBuilder: @escaping () -> FillerType) -> Item
    {
        let item = Item(actionHandler: actionHandler) {
            fillerBuilder().fill($0)
        }
        self.items.append(item)
        return item
    }

}
