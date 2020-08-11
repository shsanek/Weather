//
//  ScreenBuilder.swift
//  Core
//
//  Created by Alex Shipin on 10.08.2020.
//

import Utils

public final class ScreenBuilder<Presenter, UI: IScreenUI>
{

    public var presenterMaker: (UI) throws -> Presenter = { _ in throw BaseError.notImplementation }
    public var uiMaker: () throws -> UI = { throw BaseError.notImplementation }

    public init()
    {
    }

    public func makeScreen(hookHandler: (Presenter) -> Void = { _ in }) throws -> IScreen
    {
        let ui = try self.uiMaker()
        let presenter = try self.presenterMaker(ui)
        hookHandler(presenter)
        let vc = GenericViewController(presenter: presenter, ui: ui)
        return Screen(viewController: vc)
    }

}
