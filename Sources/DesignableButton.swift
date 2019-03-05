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
    
    required public init(style buttonStyle: String) {
        super.init(frame: .zero)
        defer {
            // putting this in a defer as didSet is not called from initialisers
            self.buttonStyle = buttonStyle
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    open func getStyles() -> [String: (DesignableButton) -> Void] {
        return DesignableButton.styles
    }
    
    public static var styles = ["": { (designableButton: DesignableButton) -> Void in
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
        }]
    
    
    public static func setStyle(style: @escaping (DesignableButton) -> Void, for key: String) {
        self.styles.updateValue(style, forKey: key.lowercased())
    }
    
    open func setStyleForAll() {
        self.reversesTitleShadowWhenHighlighted = false
        self.showsTouchWhenHighlighted = false
        self.adjustsImageWhenHighlighted = false
        
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.lineBreakMode = .byClipping //<-- MAGIC LINE
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.updateStyles()
    }
    
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
    open var cornerRadius: CGFloat? {
        return _cornerRadius != -1 ? _cornerRadius : nil
    }
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable open var _cornerRadius: CGFloat = -1 {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable open var _borderWidth: CGFloat = -1 {
        didSet {
            self.updateStyles()
        }
    }
    open var borderWidth: CGFloat? {
        return _borderWidth != -1 ? _borderWidth : nil
    }
    
    @IBInspectable open var customTextColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    
    // support for Dynamic Type without allowing the text to grow too big to fit
    @IBInspectable open var adjustsFontSizeToFitWidth: Bool = false {
        didSet {
            self.titleLabel?.adjustsFontForContentSizeCategory = self.adjustsFontSizeToFitWidth
            self.titleLabel?.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
            self.titleLabel?.baselineAdjustment = self.adjustsFontSizeToFitWidth ? .alignCenters : .alignBaselines
            
            if self.adjustsFontSizeToFitWidth {
                // When dynamic text changes we need to redraw the layout
                NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: OperationQueue.main) { [weak self] notification in
                    guard let strongSelf = self else { return }
                    strongSelf.setNeedsLayout()
                }
            }
            else {
                NotificationCenter.default.removeObserver(self, name: .UIContentSizeCategoryDidChange, object: nil)
            }
        }
    }
    
    @IBInspectable open override var isHighlighted: Bool {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable open override var isSelected: Bool {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable open override var isEnabled: Bool {
        didSet {
            self.updateStyles()
        }
    }
    
    open func updateStyles() {
        
        if self.buttonStyle.count > 0 {
            self.setStyleForAll()
        }
        
        if let styleBlock = self.getStyles()[self.buttonStyle.lowercased()] {
            styleBlock(self)
        }
        
        layer.masksToBounds = layer.cornerRadius > 0
        
        assert(self.buttonType == UIButtonType.custom, "Designable Button \"\(self.titleLabel?.text ?? "?")\" buttonType must be Custom")
    }
}

// helper to put icon above text
public extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
}
