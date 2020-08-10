//
//  GenericViewController.swift
//  Core
//
//  Created by Alex Shipin on 09.08.2020.
//

public final class GenericViewController<Presenter, UI: IScreenUI>: UIViewController
{

    private let presenter: Presenter
    private let ui: UI

    public init(presenter: Presenter, ui: UI)
    {
        self.presenter = presenter
        self.ui = ui
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView()
    {
        self.view = self.ui.rootView
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
