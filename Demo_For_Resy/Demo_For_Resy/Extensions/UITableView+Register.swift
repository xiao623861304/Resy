//
//  UITableView+Register.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type,
                                                        for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self),
                                        for: indexPath) as! T
    }
}
