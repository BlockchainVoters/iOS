//
//  EthereumAccount.swift
//  Ropsten
//
//  Created by Isaías Lima on 25/06/2018.
//  Copyright © 2018 Isaías. All rights reserved.
//

import UIKit

class EthereumAccount: NSObject {

    var address: String
    var privKey: String

    init(address: String, privKey: String) {
        self.address = address
        self.privKey = privKey
    }
}
