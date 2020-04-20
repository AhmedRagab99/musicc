//
//  String.swift
//  music
//
//  Created by Ahmed Ragab on 4/20/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation

extension String{
    func toSecureHTTPS() -> String{
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
