//
//  CitySearchScreenPresenter.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Utils
import Core

internal final class CitySearchScreenPresenter
{

    internal var didSelectCityHandler: ((_ city: City) -> Void)?
    internal var openHandler: (() -> Void)?
    internal var closeHandler: (() -> Void)?

    internal var currentSearchingText: String? = nil
    internal var currentSearchedText: String? = nil

    private let ui: ICitySearchScreenUI
    private let citySearchService: ICitySearchService
    private var currentPadge: Int = 0

    internal init(ui: ICitySearchScreenUI, citySearchService: ICitySearchService)
    {
        self.ui = ui
        self.citySearchService = citySearchService
        self.setHooks()
        self.loadWithText("")
    }

    private func loadWithText(_ text: String)
    {
        if self.currentSearchingText == text
        {
            return
        }
        self.ui.clear()
        self.currentPadge = 0
        self.loadNextPadgeWithText(text)
    }

    private func loadNextPadgeWithText(_ text: String)
    {
        self.currentSearchingText = text
        let request = CityRequest(padge: CityRequest.Padge(index: self.currentPadge,
                                                           numberOfItems: 40),
                                  text: text)
        self.citySearchService.fetch(with: request) { [weak self] (result) in
            self?.didLoad(text: text, result)
        }
    }

    private func didLoad(text: String, _ result: Result<CityRequestResutl, ModelError>)
    {
        switch result
        {
        case .failure(let error):
            assertionFailure("\(error)")
        case .success(let data):
            let nextPadgeHandler: (() -> Void)? = data.isMore ? { [weak self] in
                self?.loadNextPadgeWithText(text)
            } : nil
            self.ui.appendViewModels(data.cityList.map { city in
                CityViewModel(name: city.name) { [weak self] in
                    self?.ui.resetSearch()
                    self?.loadWithText("")
                    self?.didSelectCityHandler?(city)
                }
            }, nextPadgeRequest: nextPadgeHandler)
        }
    }

    private func setHooks()
    {
        self.ui.openHandler = { [weak self] in
            self?.openHandler?()
        }
        self.ui.updateSearchStringHandler = { [weak self] text in
            self?.loadWithText(text)
        }
    }

}
