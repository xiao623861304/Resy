//
//  ImageLoader.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/17/25.
//

import Foundation
import UIKit

public struct ImageLoader {

    static var session: ImageLoader.Session {
        return Session.shared
    }

    static var manager: ImageLoader.LoaderManager {
        return Session.manager
    }

    class Session: NSObject, URLSessionDataDelegate {

        static let shared = Session()
        static let manager = LoaderManager()

        func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
            guard let loader = getLoader(with: dataTask) else { return }
            loader.operative.receiveData.append(data)
        }

        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            guard let loader = getLoader(with: task) else { return }
            loader.complete(with: error)
        }

        func getLoader(with dataTask: URLSessionTask) -> Loader? {
            guard let url = dataTask.originalRequest?.url else { return nil }
            return ImageLoader.manager.storage[url]
        }

        func getLoader(with url: URL, task: Task) -> Loader {
            let loader = ImageLoader.manager.getLoader(with: url)
            loader.operative.update(task)
            return loader
        }
    }

    class LoaderManager {

        let session: URLSession
        let storage = HashStorage<URL, Loader>()
        var disk = Disk()

        init(configuration: URLSessionConfiguration = .default) {
            self.session = URLSession(configuration: .default, delegate: ImageLoader.session, delegateQueue: nil)
        }

        func getLoader(with url: URL) -> Loader {
            if let loader = storage[url] {
                return loader
            }

            let loader = Loader(session.dataTask(with: url), url: url, delegate: self)
            storage[url] = loader
            return loader
        }

        func getLoader(with url: URL, task: Task) -> Loader {
            let loader = getLoader(with: url)
            loader.operative.update(task)
            return loader
        }

        func remove(_ loader: Loader) {
            guard let url = storage.getKey(loader) else { return }

            storage[url] = nil
        }
    }
}
