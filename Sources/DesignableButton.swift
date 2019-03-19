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
    
    private var styles = [String: (DesignableButton) -> Void]()
    
    private static var styles = ["": { (designableButton: DesignableButton) -> Void in
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
    
    private func getStyles() -> [String: (DesignableButton) -> Void] {
        return self.styles.merging(DesignableButton.styles, uniquingKeysWith: { (first, _) in first })
    }
    
    public func setStyle(style: @escaping (DesignableButton) -> Void, for key: String) {
        self.styles.updateValue(style, forKey: key.lowercased())
    }
    
    public static func setStyle(style: @escaping (DesignableButton) -> Void, for key: String) {
        self.styles.updateValue(style, forKey: key.lowercased())
    }
    
    public func setStyleForAll() {
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
    
    @IBInspectable public var buttonStyle: String = "" {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable public var defaultColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable public var selectedColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    @IBInspectable public var disabledColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    public var cornerRadius: CGFloat? {
        return _cornerRadius != -1 ? _cornerRadius : nil
    }
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable public var _cornerRadius: CGFloat = -1 {
        didSet {
            self.updateStyles()
        }
    }
    
    @IBInspectable public var _borderWidth: CGFloat = -1 {
        didSet {
            self.updateStyles()
        }
    }
    public var borderWidth: CGFloat? {
        return _borderWidth != -1 ? _borderWidth : nil
    }
    
    @IBInspectable public var customTextColor: UIColor? {
        didSet {
            self.updateStyles()
        }
    }
    
    // support for Dynamic Type without allowing the text to grow too big to fit
    @IBInspectable public var adjustsFontSizeToFitWidth: Bool = false {
        didSet {
            self.titleLabel?.adjustsFontForContentSizeCategory = self.adjustsFontSizeToFitWidth
            self.titleLabel?.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
            self.titleLabel?.baselineAdjustment = self.adjustsFontSizeToFitWidth ? .alignCenters : .alignBaselines
            
            if self.adjustsFontSizeToFitWidth {
                // When dynamic text changes we need to redraw the layout
                NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
                    guard let strongSelf = self else { return }
                    strongSelf.setNeedsLayout()
                }
            }
            else {
                NotificationCenter.default.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
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
    
    public func updateStyles() {
        
        if self.buttonStyle.count > 0 {
            self.setStyleForAll()
        }
        
        if let styleBlock = self.getStyles()[self.buttonStyle.lowercased()] {
            styleBlock(self)
        }
        
        layer.masksToBounds = layer.cornerRadius > 0
        
        assert(self.buttonType == UIButton.ButtonType.custom, "Designable Button \"\(self.titleLabel?.text ?? "?")\" buttonType must be Custom")
    }
}

// helper to put icon above text
public extension UIButton {
    
    public func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
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
