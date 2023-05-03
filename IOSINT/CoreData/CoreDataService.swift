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
        if postExists(postModel: postModel) == true {
            TemplateErrorAlert.shared.alert(alertTitle: "Дубль поста", alertMessage: "Такой пост уже сохранён")
        } else {
            persistentContainer.performBackgroundTask { context in
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
        }
    }
    // поверка существования поста
    func postExists(postModel: PostStorage) -> Bool {
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@ AND descriptionPost == %@ AND image == %@", postModel.author, postModel.descriptionPost, postModel.image)
        var isExist = false
        do {
            let results = try context.fetch(postFetch) as [NSManagedObject]
            if results.count > 0 {
                isExist = true
            } else {
                isExist = false
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
        return isExist
    }
    func getContextByAuthor(author: String) -> [PostStorage]{
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@", author)
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
    
    func deleteContext(profilePostModel: PostStorage) {
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@ AND descriptionPost == %@ AND image == %@", profilePostModel.author, profilePostModel.descriptionPost, profilePostModel.image)
        do {
            let results = try context.fetch(postFetch) as [NSManagedObject]
            for data in results {
                context.delete(data)
            }
            try context.save()
        } catch {
            print("error \(error.localizedDescription)")
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
