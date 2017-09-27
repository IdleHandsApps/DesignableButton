DesignableButton Swift [![Language: Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)](https://swift.org)
------------------------------

A Custom UIButton with Centralised Styling and common styles available in Interface Builder

## Description

DesignableButton is a UIButton subclass that uses a centralised and reusable styling. In InterfaceBuilder, drag and drop a DesignableButton, choose you style and it applied instantly in InterfaceBuilder

## Features

* One centralised class to define you main button styles so they can be reused
* Different styles for different button states: Normal, Selected etc
* The centralised styles can be set in IB (no more IBOutlets needed for programatical styling)
* View the style in IB in realtime. Even changing button to selected state will update IB
* Individual buttons can override their centralised styles in IB
* Rounded corners and borders are easy with DesignableButton
* Buttons with an image above text are easy with DesignableButton

## How to install

Add this to your CocoaPods Podfile. *Note the IH prefix*
```
pod 'IHDesignableButton'
```

## How to use

Create an DesignableButton+Styles.swift extension file in your project
```swift
import UIKit
import IHDesignableButton // if DesignableButton is in CocoaPod
extension DesignableButton {
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        DesignableButton.setDesignableStyles(isInterfaceBuilder: true)
    }
    
    static func setDesignableStyles(isInterfaceBuilder: Bool = false) {
        
        // example style
        DesignableButton.setStyle(style: { (designableButton: DesignableButton) -> Void in
            if designableButton.isHighlighted || designableButton.isSelected {
                designableButton.setTitleColor(designableButton.customTextColor ?? UIColor.white, for: UIControlState())
                designableButton.backgroundColor = designableButton.selectedColor ?? UIColor.red
                designableButton.layer.borderColor = designableButton.selectedColor?.cgColor ?? UIColor.red.cgColor
                designableButton.layer.borderWidth = designableButton.borderWidth ?? 0
            } else if designableButton.isEnabled {
                designableButton.setTitleColor(designableButton.customTextColor ?? UIColor.white, for: UIControlState())
                designableButton.backgroundColor = designableButton.defaultColor ?? UIColor.blue
                designableButton.layer.borderColor = designableButton.defaultColor?.cgColor ?? UIColor.blue.cgColor
                designableButton.layer.borderWidth = designableButton.borderWidth ?? 0
            }
            else {
                designableButton.setTitleColor(designableButton.customTextColor ?? UIColor.lightGray, for: UIControlState())
                designableButton.backgroundColor = designableButton.disabledColor ?? UIColor.lightGray()
                designableButton.layer.borderColor = designableButton.borderColor?.cgColor ??  UIColor.gray.cgColor
                designableButton.layer.borderWidth = designableButton.borderWidth ?? 1
            }
            designableButton.setTitle(designableButton.titleLabel?.text, for: .normal)
            
            designableButton.layer.cornerRadius = designableButton.cornerRadius ?? 12
            
        }, for: "primary")
    }
}
```

In the ```setDesignableStyles()``` method you can call ```DesignableButton.setStyle()``` to create a new style. Most projects will only need a few button styles

In you AppDelegate's ```application(_ , didFinishLaunchingWithOptions()``` call ```DesignableButton.setDesignableStyles()```

Now in Interface Builder, drag a UIButton onto a view

Change the class to ```DesignableButton``` and the module to ```IHDesignableButton```

Change the button type from ```System``` to ```Custom```

Set the Button Style to "primary" or any other button style you're created


## Half price for a limited time only :)

An elegant solution for keeping views visible when the keyboard is being shown https://github.com/IdleHandsApps/IHKeyboardAvoiding

An easy way to make your NavBar transparent 
https://github.com/IdleHandsApps/UINavigationBar-Transparent

## Author

* Fraser Scott-Morrison (fraserscottmorrison@me.com)

It'd be great to hear about any cool apps that are using DesignableButton

## License 

Distributed under the MIT License
