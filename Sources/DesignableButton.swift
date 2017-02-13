//
//  DesignableButton.swift
//  Idle Hands Apps
//
//  Created by Fraser Scott-Morrison on 8/02/17.
//  Copyright © 2017 Idle Hands Apps. All rights reserved.
//

import UIKit

@IBDesignable
open class DesignableButton: UIButton {
    
    open func getStyles() -> [String: (DesignableButton) -> Void] {
        return DesignableButton.styles
    }
    
    open static var styles = ["": { (designableButton: DesignableButton) -> Void in
        // default "none" style
        if designableButton.isHighlighted || designableButton.isSelected {
            designableButton.backgroundColor = designableButton.selectedColor
        } else if designableButton.isEnabled {
            designableButton.backgroundColor = designableButton.defaultColor
        }
        else {
            designableButton.backgroundColor = designableButton.disabledColor
        }
        designableButton.layer.cornerRadius = designableButton.cornerRadius ?? 0
        designableButton.layer.borderWidth = designableButton.borderWidth ?? 0
        designableButton.layer.borderColor = designableButton.borderColor?.cgColor
        }]   // = [String: ((DesignableButton)->Void)]()
    
    
    public static func setStyle(style: @escaping (DesignableButton) -> Void, for key: String) {
        self.styles.updateValue(style, forKey: key.lowercased())
    }
    
    open func setStyleForAll() {
        self.reversesTitleShadowWhenHighlighted = false
        self.showsTouchWhenHighlighted = false
        self.adjustsImageWhenHighlighted = false
    }
    
    /*public static var styleForAll: ((DesignableButton)->Void) = {(designableButton: DesignableButton) -> Void in
     designableButton.reversesTitleShadowWhenHighlighted = false
     designableButton.showsTouchWhenHighlighted = false
     designableButton.adjustsImageWhenHighlighted = false
     }*/
    
    @IBInspectable open var buttonStyle: String = "" {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable open var defaultColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable open var selectedColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable open var disabledColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat? {
        didSet {
            self.updateStyles()
        }
    }
    
    
    @IBInspectable open var borderWidth: CGFloat? {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.updateStyles()
    }
    
    open override var isHighlighted: Bool {
        didSet {
            self.updateStyles()
        }
    }
    open override var isSelected: Bool {
        didSet {
            self.updateStyles()
        }
    }
    open override var isEnabled: Bool {
        didSet {
            self.updateStyles()
        }
    }
    
    open func updateStyles() {
        
        if self.buttonStyle.characters.count > 0 {
            self.setStyleForAll()
        }
        
        if let styleBlock = self.getStyles()[self.buttonStyle] as ((DesignableButton)->Void)! {
            styleBlock(self)
        }
        
        layer.masksToBounds = layer.cornerRadius > 0
        
        assert(self.buttonType == UIButtonType.custom, "Designable Button \"\(self.titleLabel?.text)\" buttonType must be Custom") // here
    }
}
