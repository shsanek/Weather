//
//  ScreenUI.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core
import Design

internal final class WeatherListScreenUI: IScreenUI, IWeatherListScreenUI
{

    internal var updateHandler: (() -> Void)?

    internal lazy var rootView: UIView = self.tableController.tableView
    internal let tableController = TableDataController()

    private var weatherItems: [TableDataController.Item]?
    private var textItem: TableDataController.Item?
    private let refreshControl = UIRefreshControl()

    internal init()
    {
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    internal func showLoadingState()
    {
        self.tableController.tableView.refreshControl = self.refreshControl
        refreshControl.beginRefreshing()
    }

    internal func showErrorState(text: String)
    {
        self.tableController.removeItem(self.textItem)
        let item = TableDataController.Item { (cell: UITableViewCell) in
            cell.textLabel?.text = text
        }
        self.textItem = item
        self.tableController.items.insert(item, at: 0)
    }

    internal func hideLoadingState()
    {
        refreshControl.endRefreshing()
    }

    internal func showEmpty()
    {
        self.tableController.tableView.refreshControl = nil
        self.tableController.removeItem(self.textItem)
        self.tableController.removeItems(self.weatherItems)
        let item = TableDataController.Item { (cell: UITableViewCell) in
            cell.textLabel?.text = "Выберите город"
        }
        self.textItem = item
        self.tableController.items.insert(item, at: 0)
    }

    internal func showWeathers(_ weathers: [WeatherViewModel])
    {
        self.tableController.tableView.refreshControl = self.refreshControl
        self.tableController.removeItem(self.textItem)
        self.tableController.removeItems(self.weatherItems)
        var items = [TableDataController.Item]()
        var imageProviderTasks = [UITableViewCell: Any]()
        for viewModel in weathers
        {
            let item = TableDataController.Item(actionHandler: { }){ (cell: SubtitleCell) in
                cell.textLabel?.text = viewModel.dayName
                cell.detailTextLabel?.text = viewModel.temperature
                imageProviderTasks[cell] = viewModel.imageProvider.fetch { image in
                    cell.imageView?.image = image
                }
            }
            items.append(item)
        }
        self.weatherItems = items
        self.tableController.items.append(contentsOf: items)
    }

    @objc
    private func refresh()
    {
        if self.refreshControl.isRefreshing
        {
            self.updateHandler?()
        }
    }
}

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
