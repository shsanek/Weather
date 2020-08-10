//
//  CitySearchScreenUI.swift
//  Pods
//
//  Created by Alex Shipin on 10.08.2020.
//

import Core

internal final class CitySearchScreenUI: IScreenUI, ICitySearchScreenUI
{

    internal let rootView: UIView = UIView()

    internal init()
    {
        self.rootView.backgroundColor = .red
    }

}
