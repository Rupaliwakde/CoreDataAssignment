import UIKit
import CoreData

class CoreDataManager: NSObject {

func setCurrentData(current: NSDictionary, minutely: NSArray) {
    let context = StringLiterals.appDelegate?.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "CurrentEntity", in: context!)
    let dict = NSManagedObject(entity: entity!, insertInto: context)
    do {
    let currentDict = try NSKeyedArchiver.archivedData(withRootObject: current, requiringSecureCoding: false)
    let minutelyDict = try NSKeyedArchiver.archivedData(withRootObject: minutely, requiringSecureCoding: false)
        dict.setValue(currentDict, forKey: "current")
        dict.setValue(minutelyDict, forKey: "minutely")
    } catch {
        debugPrint(error)
    }
    do {
        try context?.save()
    } catch {
        print("Failed saving")
    }
}

func getCurrentData() -> NSDictionary {

    let context = StringLiterals.appDelegate?.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentEntity")
    request.returnsObjectsAsFaults = false
    let resultDict = NSMutableDictionary()
    do {
        let results = try context?.fetch(request)
        if results?.count != 0 {
            for result in results! {
                if let currentData = (result as AnyObject).value(forKey: "current") as? NSData {
                 let currentDict = ((NSKeyedUnarchiver.unarchiveObject(with: currentData as Data)) as AnyObject)
                     as? NSDictionary
                     resultDict.setValue(currentDict, forKey: "current")
                }
                if let minutelyData =
                    (result as AnyObject).value(forKey: "minutely") as? NSData {
                    let minutelyDict =
                        ((NSKeyedUnarchiver.unarchiveObject(with: minutelyData as Data)) as AnyObject) as? NSArray
                    resultDict.setValue(minutelyDict, forKey: "minutely")
                }
            }
           return resultDict
        }
    } catch let error as NSError {
        print(error)
    }
    return NSDictionary()
}
}
