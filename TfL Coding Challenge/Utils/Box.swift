//
//  Box.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

public class Box<T> {
    public typealias Listener = (T) -> Void
    var listener: Listener?

    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func bindValue(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
