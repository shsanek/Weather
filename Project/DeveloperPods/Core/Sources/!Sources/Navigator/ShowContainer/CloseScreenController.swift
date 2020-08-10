//
//  CloseScreenController.swift
//  Core
//
//  Created by Alex Shipin on 09.08.2020.
//

public final class CloseScreenController
{

    internal var closeHandler: (() -> Void)?

    public func close()
    {
        self.closeHandler?()
    }

}
