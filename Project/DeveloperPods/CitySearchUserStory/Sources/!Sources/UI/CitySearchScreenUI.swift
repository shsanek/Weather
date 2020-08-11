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

    internal lazy var rootView: UIView = self.stackView

    private let tableController = TableDataController()
    private var lastItem: TableDataController.Item?
    private var stackView = UIStackView()
    private let textField = UITextField()
    private lazy var textFieldController = TextFieldController(textField: self.textField)

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
        self.textField.resignFirstResponder()
        self.openHandler?()
    }

    internal func clear()
    {
        self.tableController.removeItems(self.tableController.items)
    }

    internal func resetSearch()
    {
        self.textField.text = ""
        self.textField.resignFirstResponder()
    }

    private func configure()
    {
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .fill
        self.stackView.spacing = 10.0
        self.textField.backgroundColor = .white
        self.textField.placeholder = "Введите название города"

        self.stackView.addArrangedSubview(self.textField)
        self.stackView.addArrangedSubview(self.tableController.tableView)

        self.textFieldController.textFieldShouldBeginEditingHandler = { [weak self] in
            self?.openHandler?()
            return true
        }
        self.textFieldController.updateText = { [weak self] text in
            self?.updateSearchStringHandler?(text ?? "")
        }
    }

}
