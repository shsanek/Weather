//
//  CitySearchScreenUI.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Design
import Core

internal final class CitySearchScreenUI: IScreenUI, ICitySearchScreenUI
{

    internal var openHandler: (() -> Void)?
    internal var updateSearchStringHandler: ((String) -> Void)?

    internal lazy var rootView: UIView = self.stackContainerView

    private let tableController = TableDataController()
    private var lastItem: TableDataController.Item?

    private var stackContainerView = Container {
        ViewFiller<UIStackView>()
            .offset()
            .setAxis(.vertical)
            .setDistribution(.fill)
            .setAlignment(.fill)
            .setSpacing(10.0)
    }.backgroundColor(.lightGray).makeView()

    private lazy var textInputContainer = Container {
        TextField()
            .placeholder("Введите название города")
            .offset(top: 8.0, bottom: 8.0,
                    left: 16.0, right: 16.0)
            .height(44.0)
            .updateTextHandler { [weak self] (text) in
                self?.updateSearchStringHandler?(text ?? "")
            }.textFieldShouldBeginEditingHandler { [weak self] () -> Bool in
            self?.openHandler?()
            return true
        }
    }.makeView()

    internal init()
    {
        self.configure()
    }

    internal func appendViewModels(_ viewModels: [CityViewModel], nextPadgeRequest: (() -> Void)?)
    {
        var items = [TableDataController.Item]()
        for viewModel in viewModels
        {
            let item = TableDataController.Item(actionHandler: viewModel.action) { (cell: UITableViewCell) in
                cell.textLabel?.text = viewModel.name
            }
            items.append(item)
        }
        self.tableController.items.append(contentsOf: items)
        self.tableController.removeItem(self.lastItem)
        if let nextPadgeRequest = nextPadgeRequest
        {
            let item = TableDataController.Item(fillerHandler: { (_: LastView) in
                nextPadgeRequest()
            })
            self.lastItem = item
            self.tableController.items.append(item)
        }
    }

    internal func active()
    {
        self.textInputContainer.resignFirstResponder()
        self.openHandler?()
    }

    internal func clear()
    {
        self.tableController.removeItems(self.tableController.items)
    }

    internal func resetSearch()
    {
        self.textInputContainer.contentView.text = ""
        self.textInputContainer.contentView.resignFirstResponder()
    }

    private func configure()
    {
        self.stackContainerView.contentView.addArrangedSubview(self.textInputContainer)
        self.stackContainerView.contentView.addArrangedSubview(self.tableController.tableView)
    }

}
