//
//  CoreDataService.swift
//  IOSINT
//
//  Created by Эля Корельская on 23.04.2023.
//

import CoreData

class CoreDataService {
    
    // представляет контейнер, который содержит базу данных Core Data с указанным именем "PostModel". Он загружает постоянные хранилища в контейнер и проверяет наличие ошибок при загрузке.
    var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "PostModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext
    // сохраняет переданный объект модели поста в базу данных Core Data через context
    func saveContext(postModel: PostStorage) {

        let post = PostEntity(context: context)
        post.author = postModel.author
        post.descriptionPost = postModel.descriptionPost
        post.image = postModel.image
        post.likes = Int64(postModel.likes)
        post.views = Int64(postModel.views)

        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        }
//извлекает данные из базы данных Core Data и возвращает массив объектов PostStorage. Он создает запрос postFetch, который извлекает все объекты PostEntity из базы данных. Затем он перебирает массив результатов и создает новый массив savedPostsData, заполняя его экземплярами PostStorage с помощью значений, извлеченных из каждого объекта PostEntity.
    func getContext() -> [PostStorage]{
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        var savedPostsData: [PostStorage] = []
        do {
            let savedPosts = try context.fetch(postFetch)
            for data in savedPosts as [NSManagedObject] {
                savedPostsData.append(.init(
                                            author: data.value(forKey: "author") as! String,
                                            descriptionPost: data.value(forKey: "descriptionPost") as! String,
                                            image: data.value(forKey: "image") as! String,
                                            likes: data.value(forKey: "likes") as! Int,
                                            views: data.value(forKey: "views") as! Int))
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
        return savedPostsData
    }
}

