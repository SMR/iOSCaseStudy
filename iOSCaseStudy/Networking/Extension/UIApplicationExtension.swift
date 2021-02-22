//
//  UIApplicationExtension.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//
import UIKit

struct InfoPlist<T> {
    static func get(for key: String) -> T? {
        return  Bundle.main.infoDictionary?[key] as? T
    }
    
    static subscript(key: String) -> T? {
        return get(for: key)
    }
}//Usage
//let bundleIdentifier = InfoPlist<String>["CFBundleDisplayName"]
public extension UIApplication {
    func clearLaunchScreenCache() {
        #if DEBUG
        do {
            let launchScreenPath = "\(NSHomeDirectory())/Library/SplashBoard"
            try FileManager.default.removeItem(atPath: launchScreenPath)
        } catch {
            print("Failed to delete launch screen cache - \(error)")
        }
        #endif
    }
    
}
