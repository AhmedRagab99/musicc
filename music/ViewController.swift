//
//  ViewController.swift
//  music
//
//  Created by Ahmed Ragab on 4/18/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import UIKit
import Alamofire
import Lottie
import MBProgressHUD
import Kingfisher
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Api.shared.getTopCharts(genreId: 0){ (data, error) in
            if error == nil{
                print(data)
            }
        }
        }
    }



