//
//  ViewController.swift
//  Ropsten
//
//  Created by Isaías Lima on 22/06/2018.
//  Copyright © 2018 Isaías. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        BlockchainManager.initialize()

        guard let node = BlockchainManager.start_node() else {
            return
        }
        BlockchainManager.watch_node(node: node)
        print(#function, node)
    }
}

