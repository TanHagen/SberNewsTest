//
//  UIImageView+Ext.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let fileName = url.lastPathComponent
        contentMode = mode
        let path: String? = File.checkFor(file: fileName)
        if path == nil {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                    do {
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let fileURL = documentsURL.appendingPathComponent("\(fileName)")
                        if let pngImageData = image.pngData() {
                            try pngImageData.write(to: fileURL, options: .atomic)
                        }
                    } catch { }
                }
                }.resume()
        } else {
            self.image = UIImage(contentsOfFile: "\(path!)")
        }
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

final class File {
    
    static func getDocumentsDirectory() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let documents: String = paths.first else {
            return nil
        }
        return documents
    }

    static func checkFor(file: String) -> String? {
        if let documents = getDocumentsDirectory() {
            let filePath = documents + "/\(file)"
            if let escapedPath = filePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if FileManager.default.fileExists(atPath: escapedPath) {
                    return escapedPath
                }
            }
        }
        return nil
    }
}
