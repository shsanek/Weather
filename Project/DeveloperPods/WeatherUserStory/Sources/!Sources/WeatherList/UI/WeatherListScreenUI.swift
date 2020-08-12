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
        let item = self.emptyTableItem()
        self.textItem = item
        self.tableController.items.insert(item, at: 0)
    }

    internal func showViewModels(_ viewModels: [WeatherViewModel])
    {
        self.tableController.tableView.refreshControl = self.refreshControl
        self.tableController.removeItem(self.textItem)
        self.tableController.removeItems(self.weatherItems)
        let items = viewModels.map(self.tableItem(with:))
        self.weatherItems = items
        self.tableController.items.append(contentsOf: items)
    }

    private func emptyTableItem() -> TableDataController.Item
    {
        TableDataController.Item {
            Container {
                Label("Выберите город")
                    .textAlignment(.center)
                    .offset(top: 16.0,
                            bottom: 16.0,
                            left: 0.0,
                            right: 0.0)
            }
        }
    }

    private func tableItem(with viewModel: WeatherViewModel) -> TableDataController.Item
    {
        TableDataController.Item(actionHandler: viewModel.action) {
            Container {
                Stack {
                    Container {
                        Image(viewModel.imageProvider)
                            .size(width: 24, height: 24)
                            .horizontalOfsset(left: 8.0, right: 8.0)
                            .centerY()
                    }
                    Stack {
                        Label(viewModel.dayName)
                        Label(viewModel.temperature)
                    }
                    .setAxis(.vertical)
                    View()
                }
                .setAxis(.horizontal)
                .offset()
            }
        }
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
