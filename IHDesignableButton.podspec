Pod::Spec.new do |s|
  s.name             = "IHDesignableButton"
  s.version          = "2.1"

  s.summary          = "A Custom UIButton with Centralised Reusable UIButton Styles, Powered by Interface Builder"

  s.description      = <<-DESC
                       DesignableButton allows you to declare reusable button style definitions. In Interface Builder you can easily choose these style for your DesignableButtons and Interface Builder will render these styles immediately.

Common button styles, such as corner radius, are also made available in Interface Builder
                       DESC

  s.homepage         = "https://github.com/IdleHandsApps/DesignableButton/"
  s.license          = { :type => "MIT" }

  s.author           = { "Fraser Scott-Morrison" => "fraserscottmorrison@me.com" }

  s.ios.deployment_target = "10.0"
  s.swift_version = '5.0'

  s.source           = { :git => "https://github.com/IdleHandsApps/DesignableButton.git", :tag => s.version.to_s }

  s.source_files = "Sources/*.swift"

  s.framework       = "UIKit"
  s.requires_arc    = true
end
