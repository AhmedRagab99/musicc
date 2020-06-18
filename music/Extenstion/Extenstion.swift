//
//  Extenstion.swift
//  music
//
//  Created by Ahmed Ragab on 4/19/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import Foundation



extension URL{
    
    func getExteractedUrl(urlString:String)->URL{
        guard let url = URL(string: urlString) else {fatalError("unable to ectract url")}
        return url
    }
    
}
