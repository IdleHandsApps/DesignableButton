//
//  NeighbourlyButton.swift
//  IdleHandsApps
//
//  Created by Fraser on 13/02/17.
//  Copyright © 2017 IdleHandsApps Ltd. All rights reserved.
//

import UIKit
//import IHDesignableButton

extension DesignableButton {
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        DesignableButton.setDesignableStyles(isInterfaceBuilder: true)
    }
    
    static func setDesignableStyles(isInterfaceBuilder: Bool = false) {
        
        DesignableButton.setStyle(style: { (designableButton: DesignableButton) -> Void in
            if designableButton.isHighlighted || designableButton.isSelected {
                designableButton.setTitleColor(designableButton.customTextColor ?? UIColor.white, for: UIControl.State())
                designableButton.backgroundColor = designableButton.selectedColor ?? Color.redSelected()
                designableButton.layer.borderColor = designableButton.selectedColor?.cgColor ?? Color.redSelected().cgColor
                designableButton.layer.borderWidth = designableButton.borderWidth ?? 0
            } else if designableButton.isEnabled {
                designableButton.setTitleColor(designableButton.customTextColor ?? UIColor.white, for: UIControl.State())
                designableButton.backgroundColor = designableButton.defaultColor ?? Color.red()
                designableButton.layer.borderColor = designableButton.defaultColor?.cgColor ?? Color.red().cgColor
                designableButton.layer.borderWidth = designableButton.borderWidth ?? 0
            }
            else {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.gray(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.disabledColor ?? Color.grayLightest()
                designableButton.layer.borderColor = designableButton.borderColor?.cgColor ??  Color.gray().cgColor
                designableButton.layer.borderWidth = designableButton.borderWidth ?? 1
            }
            designableButton.setTitle(designableButton.titleLabel?.text, for: .normal)
            
            designableButton.layer.cornerRadius = designableButton.cornerRadius ?? 12
            
        }, for: "primary")
        
        DesignableButton.setStyle(style: { (designableButton: DesignableButton) -> Void in
            if designableButton.isHighlighted || designableButton.isSelected {
                designableButton.setTitleColor(designableButton.customTextColor ?? UIColor.white, for: UIControl.State())
                designableButton.backgroundColor = designableButton.selectedColor ?? Color.redSelected()
            } else if designableButton.isEnabled {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.red(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.defaultColor ?? UIColor.white
            }
            else {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.grayLight(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.disabledColor ?? Color.grayLightest()
            }
            designableButton.setTitle(designableButton.titleLabel?.text, for: .normal)
            
            designableButton.layer.cornerRadius = designableButton.cornerRadius ?? 12
            designableButton.layer.borderWidth = designableButton.borderWidth ?? 1
            designableButton.layer.borderColor = designableButton.borderColor != nil ? designableButton.borderColor!.cgColor : Color.red().cgColor
        }, for: "secondary")
        
        DesignableButton.setStyle(style: { (designableButton: DesignableButton) -> Void in
            if designableButton.isHighlighted {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.redSelected(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.selectedColor ?? Color.red()
                designableButton.tintColor = Color.redSelected()
            }
            else if designableButton.isSelected {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.redSelected(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.selectedColor ?? UIColor.clear
                designableButton.tintColor = Color.redSelected()
            } else if designableButton.isEnabled {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.red(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.defaultColor ?? UIColor.clear
                designableButton.tintColor = Color.red()
            }
            else {
                designableButton.setTitleColor(designableButton.customTextColor ?? Color.grayLight(), for: UIControl.State())
                designableButton.backgroundColor = designableButton.disabledColor ?? UIColor.clear
                designableButton.tintColor = Color.grayLight()
            }
            
            if isInterfaceBuilder {
                designableButton.setImage(designableButton.image(for: .normal)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            }
            
            designableButton.alignImageAndTitleVertically()
            designableButton.layer.cornerRadius = designableButton.cornerRadius ?? 12
            //designableButton.layer.borderWidth = designableButton.borderWidth ?? 1
        }, for: "Icon")
        
        DesignableButton.setStyle(style: { (designableButton: DesignableButton) -> Void in
            if designableButton.isHighlighted || designableButton.isSelected {
                designableButton.backgroundColor = designableButton.selectedColor
            } else if designableButton.isEnabled {
                designableButton.backgroundColor = designableButton.defaultColor
            }
            else {
                designableButton.backgroundColor = designableButton.disabledColor
            }
            designableButton.layer.cornerRadius = designableButton.cornerRadius ?? 12
        }, for: "plain")
    }
}
