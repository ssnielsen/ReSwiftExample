//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 color palettes.
  struct color {
    /// This `R.color.app` struct is generated, and contains static references to 1 colors.
    struct app {
      /// <span style='background-color: #6B2CF3; color: #94D30C; padding: 1px 3px;'>#6B2CF3</span> Main
      static let main = Rswift.ColorResource(name: "Main", red: 0.4196078431, green: 0.1725490196, blue: 0.9529411765, alpha: 1.0)
      
      /// <span style='background-color: #6B2CF3; color: #94D30C; padding: 1px 3px;'>#6B2CF3</span> Main
      /// 
      /// UIColor(red: 0.4196078431, green: 0.1725490196, blue: 0.9529411765, alpha: 1.0)
      static func main(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.4196078431, green: 0.1725490196, blue: 0.9529411765, alpha: 1.0)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `app.clr`.
    static let appClr = Rswift.FileResource(bundle: R.hostingBundle, name: "app", pathExtension: "clr")
    
    /// `bundle.url(forResource: "app", withExtension: "clr")`
    static func appClr(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.appClr
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `LogoPlaceholderView`.
    static let logoPlaceholderView = _R.nib._LogoPlaceholderView()
    
    /// `UINib(name: "LogoPlaceholderView", in: bundle)`
    static func logoPlaceholderView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.logoPlaceholderView)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `CustomerTableViewCell`.
    static let customerTableViewCell: Rswift.ReuseIdentifier<CustomerTableViewCell> = Rswift.ReuseIdentifier(identifier: "CustomerTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `Customers`.
    static let customers = _R.storyboard.customers()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "Customers", bundle: ...)`
    static func customers(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.customers)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _LogoPlaceholderView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "LogoPlaceholderView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> LogoPlaceholderView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? LogoPlaceholderView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try customers.validate()
    }
    
    struct customers: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Customers"
      let newCustomerNavigationController = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "NewCustomerNavigationController")
      
      func newCustomerNavigationController(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newCustomerNavigationController)
      }
      
      static func validate() throws {
        if _R.storyboard.customers().newCustomerNavigationController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newCustomerNavigationController' could not be loaded from storyboard 'Customers' as 'UIKit.UINavigationController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UITabBarController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}