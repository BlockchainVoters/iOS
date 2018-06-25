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

        let password = "qwerty1234567890"

        guard let account = BlockchainManager.new_account(password: password)
         , let data = BlockchainManager.exports_json(account: account, creationPassword: password, exportPassword: password) else {
            return
        }

        print(#function, "Account information: " + account.getAddress().getHex())

        switch BlockchainManager.manager {
        case .file(let mng):
            print(#function, mng.getAccounts().size())
        case .failure(let err):
            print(#function, err.localizedDescription)
        }

        let success = BlockchainManager.delete_account(account: account, password: password)

        print(#function, "Account deletion success: \(success)")

        guard let recovered = BlockchainManager.import_json(key: data, exportPassword: password, importPassword: password) else {
            return
        }

        print(#function, "Recovered account: " + recovered.getAddress().getHex())
    }
}

