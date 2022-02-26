import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

// MARK: - var

var window: UIWindow?

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions
                 launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setting root after application launch.
        setRoot()
        return true
}
// MARK: - for setting root

func setRoot() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        // ViewController = Name of first controller
        let mainView = WeatherDataListVC()
        nav1.viewControllers = [mainView]
        self.window?.rootViewController = nav1
        self.window?.makeKeyAndVisible()
    }
// MARK: - Core Data stack

lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
    })
        return container
}()

// MARK: - Core Data Saving support

func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
