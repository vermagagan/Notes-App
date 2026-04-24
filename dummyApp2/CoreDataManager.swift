import CoreData
import UIKit
class CoreDataManager{
    //1. singleton instance
    static let shared = CoreDataManager()
    private init() {}
    
    
    //2. Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Note")
        
        container.loadPersistentStores{(storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
                
        }
        return container
    }()
    
    //3. Main thread - UI Updates
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    //4.SaveContext
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
                print("Context Saved SuccessFully")
            }catch{
                let nserror = error as NSError
                fatalError("Error \(nserror)")
            }
        }
    }
    
    func createNotes(title: String, description: String){
        let context = CoreDataManager.shared.context
        
        let newNote = Note(context: context)
        newNote.id = UUID()
        newNote.title = title
        newNote.body = description
        newNote.createdAt = Date()
        
        CoreDataManager.shared.saveContext()
    }
    
    func fetchNotes() -> [Note]{
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        
        do{
            let notes = try context.fetch(fetchRequest)
            return notes
        }catch{
            print("Note does not exits \(error)")
            return []
        }
    }
    
    
    func updateNotes(note: Note, newtitle: String, newbody: String){
        note.title = newtitle
        note.body = newbody
        CoreDataManager.shared.saveContext()
    }
    
    
    func deleteNotes(note: Note){
        let context = CoreDataManager.shared.context
        
        context.delete(note)
        CoreDataManager.shared.saveContext()
    }
}
