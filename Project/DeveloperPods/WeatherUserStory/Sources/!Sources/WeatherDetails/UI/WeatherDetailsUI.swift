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


    internal lazy var rootView: UIView = stackContainerView
    private lazy var stackContainerView = Container {
        ViewFiller<UIStackView>()
            .offset()
    }.backgroundColor(self.skin.palette.background.main).makeView()
    private let skin: Skin

    internal init(skin: Skin)
    {
        self.skin = skin
    }

    internal func rebuild(_ viewModel: WeatherDetailsViewModel)
    {
        self.stackContainerView.contentView.subviews.forEach({ $0.removeFromSuperview() })
        self.stackContainerView.contentView.addArrangedSubview(self.createView(viewModel))
    }

    private func createView(_ viewModel: WeatherDetailsViewModel) -> UIView
    {
        return Stack {
            View()
                .height(skin.layout.verticalBigMargin)
            Label(viewModel.dayName)
                .textAlignment(.center)
                .textColor(skin.palette.text.main)
                .font(skin.font.bitTitle)
            Container {
                Image(viewModel.imageProvider)
                    .size(width: 64, height: 64)
                    .verticalOfsset()
                    .centerX()
            }
            Label(viewModel.temperature)
                .textAlignment(.center)
                .textColor(skin.palette.text.main)
                .font(skin.font.title)
            View()
        }
        .setAxis(.vertical)
        .makeView()
    }

}
