//
//  Skin.swift
//  Design
//
//  Created by Alex Shipin on 12.08.2020.
//

internal func RGB(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat = 1.0) -> UIColor
{
    return UIColor(red: CGFloat(r) / 255.0,
                   green: CGFloat(g) / 255.0,
                   blue: CGFloat(b) / 255.0,
                   alpha: a)

}


internal func Color(light: UIColor, dark: UIColor? = nil) -> UIColor
{
    if #available(iOS 13.0, *) {
        return UIColor { (colletion) -> UIColor in
            switch colletion.userInterfaceStyle
            {
            case .dark:
                return dark ?? light
            case .light:
                return light
            case .unspecified:
                return light
            @unknown default:
                return light
            }
        }
    } else {
        return light
    }
}

public struct Skin
{

    public struct Palette
    {

        public struct Text
        {

            public let main = Color(light: .black, dark: .white)
            public let details = Color(light: RGB(122, 122, 120))
            public let error = Color(light: RGB(255, 70, 51))

        }

        public struct Background
        {

            public let main = Color(light: .white, dark: .black)
            public let support = Color(light: RGB(240, 240, 238), dark: RGB(30, 30, 28))

        }

        public let text = Text()
        public let background = Background()

    }

    public struct Layout
    {

        public let verticalBigMargin: CGFloat = 16.0
        public let verticalLightMargin: CGFloat = 8.0

        public let horizontalMargin: CGFloat = 16.0
        public let cornerRadius: CGFloat = 8.0

    }

    public struct Font
    {

        public let main = UIFont.systemFont(ofSize: 17.0)
        public let details = UIFont.systemFont(ofSize: 13.0)
        public let title = UIFont.systemFont(ofSize: 21, weight: .semibold)
        public let bitTitle = UIFont.systemFont(ofSize: 28, weight: .bold)

    }

    public let palette = Palette()
    public let layout = Layout()
    public let font = Font()

    public init() { }

}
