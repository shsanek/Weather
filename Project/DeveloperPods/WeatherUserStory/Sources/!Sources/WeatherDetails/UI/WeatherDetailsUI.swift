//
//  WeatherDetailsUI.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

import Core
import Design

internal final class WeatherDetailsUI: IWeatherDetailsUI, IScreenUI
{

    internal var rootView: UIView = UIView()

    internal init()
    {
        self.rootView.backgroundColor = .yellow
    }

}
