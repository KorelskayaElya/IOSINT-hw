//
//  ImageViewController.swift
//  IOSINT
//
//  Created by Эля Корельская on 01.03.2023.
//

import UIKit

class ImageViewController: UITableViewController {
    
    weak var coordinator: FeedCoordinator?
    // создаем путь
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    // создание ячейки
    var file: [String] {
        do {
            // Выполняет поверхностный поиск по указанному каталогу и возвращает пути к любым содержащимся элементам
            return try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = UIColor(named: "Pink")
    }
    
    func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Последний компонент пути приемника
        title = NSString(string: path).lastPathComponent
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Photo", style: .done, target: self, action: #selector(tapBtn))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        
    }
    // запускаем пикер
    @objc func tapBtn() {
        ImagePicker.defaultPicker.getImage(in: self)
    }
    // количество ячеек
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return file.count
    }
    // размер ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // добавляем файлы картинок в таблицу
        cell.textLabel?.text = file[indexPath.row]
        cell.backgroundColor = UIColor(named: "Pink")
        // путь к изображению
        let imagePath = path + "/" + file[indexPath.row]
        cell.imageView?.image = UIImage(contentsOfFile: imagePath)
        return cell
    }
    // для удаления ячейки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // путь удаления
            let deletePath = path + "/" + file[indexPath.row]
            // удалить изображение
            try? FileManager.default.removeItem(atPath: deletePath)
            // удаление ячейки
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
    
extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // вернуть изображение
        if let image = selectedImage.jpegData(compressionQuality: 1.0) {
            do {
                let file = getDocumentsDirectory().appendingPathComponent(randomElement())
                // записать название ячейки
                try image.write(to: file)
                // обновить таблицу
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    // создать название выбранного изображения
    private func randomElement() -> String {
        let nameOfFile = "123456789"
        let random  = String(nameOfFile.randomElement() ?? "0")
        return random
    }
    // Найдет и при необходимости создает указанный общий каталог в домене
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

