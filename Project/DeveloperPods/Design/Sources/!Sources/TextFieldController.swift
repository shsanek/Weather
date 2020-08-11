//
//  TextFieldController.swift
//  CitySearchUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

import UIKit

public class TextFieldController: NSObject, UITextFieldDelegate
{

    public var updateText: ((String?) -> Void)?
    public var textFieldShouldBeginEditingHandler: (() -> Bool)?

    public init(textField: UITextField)
    {
        super.init()
        textField.delegate = self
        textField.addTarget(self, action: #selector(didUpdateText(_:)), for: .editingChanged)
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return self.textFieldShouldBeginEditingHandler?() ?? true
    }

    @objc
    private func didUpdateText(_ textField: UITextField)
    {
        self.updateText?(textField.text ?? "")
    }

}
