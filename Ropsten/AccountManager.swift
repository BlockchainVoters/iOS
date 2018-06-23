//
//  AccountManager.swift
//  Ropsten
//
//  Created by Isaías Lima on 22/06/2018.
//  Copyright © 2018 Isaías. All rights reserved.
//

import UIKit
import Geth

class AccountManager {

    class func test() {

        do {
            guard let dataDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                , let store = GEGethNewAccountManager(dataDir + "/keystore", GEGethStandardScryptN, GEGethStandardScryptP) else {
                    return
            }

            var account: GEGethAccount?
            try store.newAccount("qwerty1234567890", ret0_: &account)

            var key: NSData?
            try store.exportKey(account, passphrase: "qwerty1234567890", newPassphrase: "mnbvcx0987654321", ret0_: &key)

            try store.delete(account!, passphrase: "qwerty1234567890")
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}
