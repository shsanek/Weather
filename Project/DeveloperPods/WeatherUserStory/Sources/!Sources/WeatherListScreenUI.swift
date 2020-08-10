//
//  ScreenUI.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core

internal final class WeatherListScreenUI: IScreenUI, IWeatherListScreenUI
{

    internal let rootView: UIView = UIView()

    internal init()
    {
        self.rootView.backgroundColor = .yellow
    }

}
