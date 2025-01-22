//
//  UIImageView+ImageLoader.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/17/25.
//

import Foundation
import UIKit
import ImageIO

private var ImageLoaderRequestUrlKey = 0
private let _ioQueue = DispatchQueue(label: "swift.imageloader.queues.io", attributes: .concurrent)

extension UIImageView {
    fileprivate var requestUrl: URL? {
        get {
            var requestUrl: URL?
            _ioQueue.sync {
                requestUrl = objc_getAssociatedObject(self, &ImageLoaderRequestUrlKey) as? URL
            }

            return requestUrl
        }
        set(newValue) {
            _ioQueue.async {
                objc_setAssociatedObject(self, &ImageLoaderRequestUrlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

extension Loadable where Base: UIImageView {

    @discardableResult
    public func request(with url: URL?, placeholder: UIImage?, onCompletion: @escaping (UIImage?, Error?, FetchOperation) -> Void = { _,_,_ in } ) -> Loader? {
        guard let imageLoaderUrl = url else { return nil }

        let imageCompletion: (UIImage?, Error?, FetchOperation) -> Void = { image, error, operation in
            guard let image = image else { return onCompletion(nil, error, operation)  }

            DispatchQueue.main.async {
                self.base.image = image
                onCompletion(image, error, operation)
            }
        }
        let task = Task(base, onCompletion: imageCompletion)
        // cancel
        if let requestUrl = base.requestUrl {
            let loader = ImageLoader.manager.getLoader(with: requestUrl)
            loader.operative.remove(task)
            if requestUrl != imageLoaderUrl, loader.operative.tasks.isEmpty {
                loader.cancel()
            }
        }
        base.requestUrl = url
        // disk
        base.image = placeholder ?? nil
        if let data = ImageLoader.manager.disk.get(imageLoaderUrl) {
            guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
                return nil
            }
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
                return nil
            }
            task.onCompletion(UIImage(cgImage: cgImage), nil, .disk)
            return nil
        }

        // request
        let loader = ImageLoader.manager.getLoader(with: imageLoaderUrl, task: task)
        loader.resume()
        return loader
    }
    
    public func cancelCurrentImageLoad() {
        
        if let requestUrl = base.requestUrl {
            let loader = ImageLoader.manager.getLoader(with: requestUrl)
            loader.cancel()
        }
    }
    
    public func cancelImageLoadingTaskWhileScrolling(with imageLoaderUrl: URL?, placeholder: UIImage?, onCompletion: @escaping (FetchOperation) -> Void) {
        guard let url = imageLoaderUrl else { return }

        let loader = ImageLoader.manager.getLoader(with: url)
        loader.cancel()
        if let data = ImageLoader.manager.disk.get(url), let image = UIImage(data: data) {
            base.image = image
            onCompletion(.disk)
        } else {
            base.image = placeholder ?? nil
            onCompletion(.error)
        }
    }
}
