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
    internal lazy var stackContainerView = Container {
        ViewFiller<UIStackView>()
            .offset()
    }.backgroundColor(.white).makeView()

    internal func rebuild(_ viewModel: WeatherDetailsViewModel)
    {
        self.stackContainerView.contentView.subviews.forEach({ $0.removeFromSuperview() })
        self.stackContainerView.contentView.addArrangedSubview(self.createView(viewModel))
    }

    private func createView(_ viewModel: WeatherDetailsViewModel) -> UIView
    {
        return Stack {
            Label(viewModel.dayName)
                .textAlignment(.center)
            Container {
                Image(viewModel.imageProvider)
                    .size(width: 24, height: 24)
                    .verticalOfsset()
                    .centerX()
            }
            Label(viewModel.temperature)
                .textAlignment(.center)
            View()
        }
            .setAxis(.vertical)
            .makeView()
    }

}
