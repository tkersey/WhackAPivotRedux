import UIKit

let appDelegateName = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil ? "AppDelegate" : "TestAppDelegate"

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, "\(NSStringFromClass(AppDelegate.self).components(separatedBy: ".")[0]).\(appDelegateName)")
