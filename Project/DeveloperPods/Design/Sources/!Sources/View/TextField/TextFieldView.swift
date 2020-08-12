//
//  TextField.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

import UIKit

public final class TextFieldView: UITextField, UITextFieldDelegate
{

    public var updateText: ((String?) -> Void)?
    public var textFieldShouldBeginEditingHandler: (() -> Bool)?


    public init()
    {
        super.init(frame: .zero)
        self.configure()
    }

    public override init(frame: CGRect)
    {
        super.init(frame: .zero)
        self.configure()
    }

    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.configure()
    }

    private func configure()
    {
        self.delegate = self
        self.addTarget(self, action: #selector(didUpdateText(_:)), for: .editingChanged)
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
