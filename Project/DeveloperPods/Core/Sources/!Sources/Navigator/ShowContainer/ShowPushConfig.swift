//
//  ShowPushConfig.swift
//  Core
//
//  Created by Alex Shipin on 09.08.2020.
//

public struct ShowPushConfig
{

    public let screen: IScreen
    public let closeController = CloseScreenController()

    public init(screen: IScreen)
    {
        self.screen = screen
    }

}
