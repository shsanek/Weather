//
//  ScreenBuilder.swift
//  Core
//
//  Created by Alex Shipin on 10.08.2020.
//

import Utils

public final class ScreenBuilder<Presenter, UI: IScreenUI>
{

    public let presenterMaker: (UI) -> Presenter
    public let uiMaker: () -> UI

    public init(presenterMaker: @escaping (UI) -> Presenter, uiMaker: @escaping () -> UI)
    {
        self.presenterMaker = presenterMaker
        self.uiMaker = uiMaker
    }

    public func makeScreen(hookHandler: (Presenter) -> Void = { _ in }) -> IScreen
    {
        let ui = self.uiMaker()
        let presenter = self.presenterMaker(ui)
        hookHandler(presenter)
        let vc = GenericViewController(presenter: presenter, ui: ui)
        return Screen(viewController: vc)
    }

}

public final class ScreenBuilderWithArgument<Presenter, UI: IScreenUI, Argument>
{

    public var presenterMaker: (UI, Argument) -> Presenter
    public var uiMaker: () -> UI

    public init(presenterMaker: @escaping (UI, Argument) -> Presenter, uiMaker: @escaping () -> UI)
    {
        self.presenterMaker = presenterMaker
        self.uiMaker = uiMaker
    }

    public func makeScreen(_ arg: Argument, hookHandler: (Presenter) -> Void = { _ in }) -> IScreen
    {
        let ui = self.uiMaker()
        let presenter = self.presenterMaker(ui, arg)
        hookHandler(presenter)
        let vc = GenericViewController(presenter: presenter, ui: ui)
        return Screen(viewController: vc)
    }

}
