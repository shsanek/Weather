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
    private var titleItem: TableDataController.Item?

    private let refreshControl = UIRefreshControl()
    private let skin: Skin

    internal init(skin: Skin)
    {
        self.skin = skin
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableController.tableView.backgroundColor = skin.palette.background.main
    }

    internal func showLoadingState()
    {
        self.tableController.tableView.refreshControl = self.refreshControl
        self.refreshControl.beginRefreshing()
    }

    internal func showErrorState(text: String)
    {
        self.tableController.removeItem(self.textItem)
        let item = self.errorTableItem(text)
        self.textItem = item
        self.tableController.items.insert(item, at: 0)
    }


    internal func hideLoadingState()
    {
        refreshControl.endRefreshing()
    }

    internal func showEmpty()
    {
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

    internal func setCityName(_ name: String)
    {
        self.tableController.removeItem(self.titleItem)
        self.titleItem = self.tableController.insertItem(at: 0) {
            Container {
                Label(name)
                    .font(skin.font.bitTitle)
                    .textColor(skin.palette.text.main)
                    .textAlignment(.left)
                    .offset(top: skin.layout.verticalBigMargin,
                            bottom: skin.layout.verticalBigMargin,
                            left: skin.layout.horizontalMargin,
                            right: skin.layout.horizontalMargin)
            }
        }
    }

    private func errorTableItem(_ text: String) -> TableDataController.Item
    {
        TableDataController.Item {
            Container {
                Label(text)
                    .font(skin.font.main)
                    .textColor(skin.palette.text.error)
                    .textAlignment(.center)
                    .offset(top: skin.layout.verticalBigMargin,
                            bottom: skin.layout.verticalBigMargin,
                            left: skin.layout.horizontalMargin,
                            right: skin.layout.horizontalMargin)
            }
        }
    }

    private func emptyTableItem() -> TableDataController.Item
    {
        TableDataController.Item {
            Container {
                Label("Выберите город")
                    .font(skin.font.title)
                    .textColor(skin.palette.text.details)
                    .textAlignment(.center)
                    .offset(top: skin.layout.verticalBigMargin,
                            bottom: skin.layout.verticalBigMargin,
                            left: skin.layout.horizontalMargin,
                            right: skin.layout.horizontalMargin)
            }
        }
    }

    private func tableItem(with viewModel: WeatherViewModel) -> TableDataController.Item
    {
        TableDataController.Item(actionHandler: viewModel.action) {
            Container {
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
                                .font(skin.font.main)
                                .textColor(skin.palette.text.main)
                            View()
                                .height(skin.layout.verticalLightMargin)
                            Label(viewModel.temperature)
                                .font(skin.font.details)
                                .textColor(skin.palette.text.details)
                        }
                        .setAxis(.vertical)
                        View()
                    }
                    .setAxis(.horizontal)
                    .offset(top: 8.0,
                            bottom: 8.0,
                            left: 8.0,
                            right: 8.0)
                }
                .offset(top: skin.layout.verticalLightMargin,
                        bottom: skin.layout.verticalLightMargin,
                        left: skin.layout.horizontalMargin,
                        right: skin.layout.horizontalMargin)
                .backgroundColor(skin.palette.background.support)
                .cornerRadius(skin.layout.cornerRadius)
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
