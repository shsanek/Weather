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

    private lazy var stackContainerView = Container {
        ViewFiller<UIStackView>()
            .offset(bottom: -self.skin.layout.cornerRadius)
            .setAxis(.vertical)
            .setDistribution(.fill)
            .setAlignment(.fill)
            .setSpacing(10.0)
    }
    .cornerRadius(self.skin.layout.cornerRadius)
    .backgroundColor(self.skin.palette.background.support).makeView()

    private lazy var textInputContainer = Container {
        TextField()
            .placeholder("Введите название города")
            .offset(top: 8.0,
                    bottom: 8.0,
                    left: self.skin.layout.horizontalMargin,
                    right: self.skin.layout.horizontalMargin)
            .height(44.0)
            .font(self.skin.font.main)
            .textColor(self.skin.palette.text.main)
            .updateTextHandler { [weak self] (text) in
                self?.updateSearchStringHandler?(text ?? "")
            }.textFieldShouldBeginEditingHandler { [weak self] () -> Bool in
            self?.openHandler?()
            return true
        }
    }.makeView()

    private let skin: Skin

    internal init(skin: Skin)
    {
        self.skin = skin
        self.configure()
    }

    internal func appendViewModels(_ viewModels: [CityViewModel], nextPadgeRequest: (() -> Void)?)
    {
        var items = [TableDataController.Item]()
        for viewModel in viewModels
        {
            let item = TableDataController.Item(actionHandler: viewModel.action) { [skin] (cell: UITableViewCell) in
                cell.textLabel?.text = viewModel.name
                cell.textLabel?.textColor = skin.palette.text.main
                cell.textLabel?.font = skin.font.main
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
        self.stackContainerView.contentView.addArrangedSubview(View().height(skin.layout.cornerRadius).makeView())
    }

}
