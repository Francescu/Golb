//
//  Result.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation

enum Result<T> {
    case Error(NSError?), Success(T)
}