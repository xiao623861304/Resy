//
//  Loader.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/17/25.
//

import Foundation
import UIKit
import ImageIO

public struct Loader {

    unowned let delegate: ImageLoader.LoaderManager
    let task: URLSessionDataTask
    let operative = Operative()
    let url: URL

    init(_ task: URLSessionDataTask, url: URL, delegate: ImageLoader.LoaderManager) {
        self.task = task
        self.url = url
        self.delegate = delegate
    }

    public var state: URLSessionTask.State {
        return task.state
    }

    public func resume() {
        task.resume()
    }

    public func cancel() {
        task.cancel()

        let reason = "Cancel to request: \(url)"
        onFailure(with: NSError(domain: "Imageloader", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey: reason]))
    }

    func complete(with error: Error?) {
        if let error = error {
            onFailure(with: error)
            return
        }
        
        guard let imageSource = CGImageSourceCreateWithData(operative.receiveData as CFData, nil) else {
            return
        }
        if let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) {
            let image = UIImage(cgImage: cgImage)
            onSuccess(with: image)
            delegate.disk.set(operative.receiveData, forKey: url)
            return
        }

        if let statusCode = (task.response as? HTTPURLResponse)?.statusCode, statusCode >= 200, statusCode < 400 {
            let reason = "Disconnect on downloading caused by HTTPStatusCode: \(statusCode)"
            onFailure(with: NSError(domain: "Imageloader", code: statusCode, userInfo: [NSLocalizedFailureReasonErrorKey: reason]))
            return
        }

        failOnConvertToImage()
    }

    private func failOnConvertToImage() {
        onFailure(with: NSError(domain: "Imageloader", code: -999, userInfo: [NSLocalizedFailureReasonErrorKey: "Failure when convert image"]))
    }

    private func onSuccess(with image: UIImage) {
        operative.tasks.forEach { task in
            task.onCompletion(image, nil, .network)
        }
        operative.tasks = []
        delegate.remove(self)
    }

    private func onFailure(with error: Error) {
        operative.tasks.forEach { task in
            task.onCompletion(nil, error, .error)
        }
        operative.tasks = []
        delegate.remove(self)
    }
}

extension Loader: Equatable {}

public func ==(lhs: Loader, rhs: Loader) -> Bool {
    return lhs.task == rhs.task
}
