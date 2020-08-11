//
//  LastView.swift
//  CitySearchUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

import UIKit

internal final class LastView: UIStackView
{

    internal init()
    {
        super.init(frame: .zero)
        self.configure()
    }

    internal override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.configure()
    }

    required init(coder: NSCoder)
    {
        super.init(coder: coder)
        self.configure()
    }

    private func configure()
    {
        self.axis = .vertical
        self.alignment = .center
        let activityIndicatorView = UIActivityIndicatorView()
        self.addArrangedSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

}

