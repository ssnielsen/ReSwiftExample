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
    /// This `R.color.app` struct is generated, and contains static references to 3 colors.
    struct app {
      /// <span style='background-color: #5021B5; color: #AFDE4A; padding: 1px 3px;'>#5021B5</span> Main
      static let main = Rswift.ColorResource(name: "Main", red: 0.3137254902, green: 0.1294117647, blue: 0.7098039216, alpha: 1.0)
      /// <span style='background-color: #6B2CF3; color: #94D30C; padding: 1px 3px;'>#6B2CF3</span> Light
      static let light = Rswift.ColorResource(name: "Light", red: 0.4196078431, green: 0.1725490196, blue: 0.9529411765, alpha: 1.0)
      /// <span style='background-color: #7658B7; color: #89A748; padding: 1px 3px;'>#7658B7</span> VeryLight
      static let veryLight = Rswift.ColorResource(name: "VeryLight", red: 0.462745098, green: 0.3450980392, blue: 0.7176470588, alpha: 1.0)
      
      /// <span style='background-color: #5021B5; color: #AFDE4A; padding: 1px 3px;'>#5021B5</span> Main
      /// 
      /// UIColor(red: 0.3137254902, green: 0.1294117647, blue: 0.7098039216, alpha: 1.0)
      static func main(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.3137254902, green: 0.1294117647, blue: 0.7098039216, alpha: 1.0)
      }
      
      /// <span style='background-color: #6B2CF3; color: #94D30C; padding: 1px 3px;'>#6B2CF3</span> Light
      /// 
      /// UIColor(red: 0.4196078431, green: 0.1725490196, blue: 0.9529411765, alpha: 1.0)
      static func light(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.4196078431, green: 0.1725490196, blue: 0.9529411765, alpha: 1.0)
      }
      
      /// <span style='background-color: #7658B7; color: #89A748; padding: 1px 3px;'>#7658B7</span> VeryLight
      /// 
      /// UIColor(red: 0.462745098, green: 0.3450980392, blue: 0.7176470588, alpha: 1.0)
      static func veryLight(_: Void = ()) -> UIKit.UIColor {
        return UIKit.UIColor(red: 0.462745098, green: 0.3450980392, blue: 0.7176470588, alpha: 1.0)
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
  
  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `barbutton_sort`.
    static let barbutton_sort = Rswift.ImageResource(bundle: R.hostingBundle, name: "barbutton_sort")
    /// Image `tabbar_customers`.
    static let tabbar_customers = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_customers")
    
    /// `UIImage(named: "barbutton_sort", bundle: ..., traitCollection: ...)`
    static func barbutton_sort(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.barbutton_sort, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "tabbar_customers", bundle: ..., traitCollection: ...)`
    static func tabbar_customers(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_customers, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
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
  
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `AddCustomer`.
    static let addCustomer = _R.storyboard.addCustomer()
    /// Storyboard `Customers`.
    static let customers = _R.storyboard.customers()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "AddCustomer", bundle: ...)`
    static func addCustomer(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.addCustomer)
    }
    
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
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try addCustomer.validate()
      try customers.validate()
    }
    
    struct addCustomer: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "AddCustomer"
      let newCustomerNavigationController = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "NewCustomerNavigationController")
      
      func newCustomerNavigationController(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newCustomerNavigationController)
      }
      
      static func validate() throws {
        if _R.storyboard.addCustomer().newCustomerNavigationController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newCustomerNavigationController' could not be loaded from storyboard 'AddCustomer' as 'UIKit.UINavigationController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct customers: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Customers"
      
      static func validate() throws {
        if UIKit.UIImage(named: "barbutton_sort") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'barbutton_sort' is used in storyboard 'Customers', but couldn't be loaded.") }
        if UIKit.UIImage(named: "tabbar_customers") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'tabbar_customers' is used in storyboard 'Customers', but couldn't be loaded.") }
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