//
//  IObjectFillerSetting+TextField.swift
//  App
//
//  Created by Alex Shipin on 12.08.2020.
//

public typealias TextField = ViewFiller<TextFieldView>

extension IObjectFillerSetting where ObjectType: UITextField
{

    public func text(_ text: String?) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.text = text
        }
    }

    public func placeholder(_ text: String?) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.placeholder = text
        }
    }

    public func font(_ font: UIFont) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.font = font
        }
    }

    public func textColor(_ color: UIColor) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.textColor = color
        }
    }

}

extension IObjectFillerSetting where ObjectType: TextFieldView
{

    public func updateTextHandler(_ handler: @escaping (String?) -> Void) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.updateText = handler
        }
    }

    public func textFieldShouldBeginEditingHandler(_ handler: @escaping () -> Bool) -> Self
    {
        return self.addFillHandler { (obj) in
            obj.textFieldShouldBeginEditingHandler = handler
        }
    }

}
