import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem], _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            if !dishExists(menuItem.title, context) {
                let dish = Dish(context: context)
                dish.name = menuItem.title
                dish.price = Float(menuItem.price) ?? 0.0
            }
        }
    }
    
    private static func dishExists(_ name: String, _ context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<Dish> = Dish.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let dishes = try context.fetch(request)
            return dishes.count > 0
        } catch {
            print("Failed to fetch dishes: \(error)")
            return false
        }
    }
    
}
