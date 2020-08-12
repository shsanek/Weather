//
//  StackBuilder.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

@_functionBuilder
public struct StackBuilder
{

    public static func buildBlock() -> StackViewContent<Void>
    {
        StackViewContent([])
    }

    public static func buildBlock<Content: IViewFiller>(_ content: Content) -> StackViewContent<Content>
    {
        StackViewContent([.make(content)])
    }

}

extension StackBuilder
{

    public static func buildBlock<C0: IViewFiller, C1: IViewFiller>
        (_ c0: C0, _ c1: C1) -> StackViewContent<(C0, C1)>
    {
        StackViewContent([.make(c0), .make(c1)])
    }

    public static func buildBlock<C0: IViewFiller, C1: IViewFiller, C2: IViewFiller>
        (_ c0: C0, _ c1: C1, _ c2: C2) -> StackViewContent<(C0, C1, C2)>
    {
        StackViewContent([.make(c0), .make(c1), .make(c2)])
    }

    public static func buildBlock<C0: IViewFiller, C1: IViewFiller, C2: IViewFiller, C3: IViewFiller>
        (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> StackViewContent<(C0, C1, C2, C3)>
    {
        StackViewContent([.make(c0), .make(c1), .make(c2), .make(c3)])
    }

    public static func buildBlock<C0: IViewFiller, C1: IViewFiller, C2: IViewFiller, C3: IViewFiller, C4: IViewFiller>
        (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> StackViewContent<(C0, C1, C2, C3, C4)>
    {
        StackViewContent([.make(c0), .make(c1), .make(c2), .make(c3), .make(c4)])
    }

}
