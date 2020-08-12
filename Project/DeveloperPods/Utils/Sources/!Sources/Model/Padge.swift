//
//  Padge.swift
//  Utils
//
//  Created by Alex Shipin on 12.08.2020.
//

public struct Padge
{

    internal let index: Int
    internal let count: Int

    public static func make(index: Int, count: Int) -> Padge
    {
        return Padge(index: index, count: count)
    }

}
