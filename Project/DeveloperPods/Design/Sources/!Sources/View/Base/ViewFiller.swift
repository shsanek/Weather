//
//  ViewFiller.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//


public protocol IViewFiller: IObjectFiller where ObjectType: UIView
{

}


public struct ViewFiller<ObjectType: UIView>: IObjectFiller, IObjectFillerSetting, IObjectFillerInitable, IViewFiller
{

    private var fillers = [(ObjectType) -> Void]()

    public init()
    {
        self.fillers.append { (obj) in
            obj.removeCustomConstraints()
        }
    }

    public func addFillHandler(_ handler: @escaping (ObjectType) -> Void) -> ViewFiller<ObjectType>
    {
        var result = self
        result.fillers.append(handler)
        return result
    }

    public func fill(_ object: ObjectType)
    {
        self.fillers.forEach { $0(object) }
    }

    public func makeView(isFill: Bool = true) -> ObjectType
    {
        let view = ObjectType()
        if isFill
        {
            self.fill(view)
        }
        return view
    }



}
