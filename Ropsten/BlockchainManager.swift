//
//  BlockchainManager.swift
//  Ropsten
//
//  Created by Isaías Lima on 22/06/2018.
//  Copyright © 2018 Isaías. All rights reserved.
//

import UIKit
import Geth
import JASON

enum BlockchainFile<T> {
    case file(T)
    case failure(Error)
}

class BlockchainManager {

    private static let dataDir: String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    private static let null_error: Error = NSError(domain: NSCocoaErrorDomain, code: 404, userInfo: [NSLocalizedDescriptionKey : "This variable is nil."]) as Error
    static var manager: BlockchainFile<GEGethAccountManager> = .failure(null_error)

    class func initialize() {
        guard let dir = dataDir
            , let mng = GEGethNewAccountManager(dir + "/keystore", GEGethStandardScryptN, GEGethStandardScryptP) else {
                let error = NSError(domain: NSCocoaErrorDomain, code: 404, userInfo: [NSLocalizedDescriptionKey : "The document directory couldn't be accessed. Try later."])
                manager = .failure(error as Error)
                return
        }
        manager = .file(mng)
    }

    class func new_account(password: String) -> GEGethAccount? {

        var new: GEGethAccount?

        do {
            switch manager {
            case .file(let mng):
                try mng.newAccount(password, ret0_: &new)
                return new
            case .failure(let err):
                print(#function, err.localizedDescription)
                throw err
            }
        } catch {
            print(#function, error.localizedDescription)
            return nil
        }
    }

    class func exports_json(account: GEGethAccount, creationPassword: String, exportPassword: String) -> Data? {

        var jKey: NSData?

        do {
            switch manager {
            case .file(let mng):
                try mng.exportKey(account, passphrase: creationPassword, newPassphrase: exportPassword, ret0_: &jKey)
                if jKey == nil { return nil }
                return jKey! as Data
            case .failure(let err):
                print(#function, err.localizedDescription)
                throw err
            }
        } catch {
            print(#function, error.localizedDescription)
            return nil
        }
    }

    class func delete_account(account: GEGethAccount, password: String) -> Bool {
        do {
            switch manager {
            case .file(let mng):
                try mng.delete(account, passphrase: password)
                return true
            case .failure(let err):
                print(#function, err.localizedDescription)
                throw err
            }
        } catch {
            print(#function, error.localizedDescription)
            return false
        }
    }

    class func import_json(key: Data, exportPassword: String, importPassword: String) -> GEGethAccount? {

        var new: GEGethAccount?

        do {
            switch manager {
            case .file(let mng):
                try mng.importKey(key, passphrase: exportPassword, newPassphrase: importPassword, ret0_: &new)
                return new
            case .failure(let err):
                print(#function, err.localizedDescription)
                throw err
            }
        } catch {
            print(#function, error.localizedDescription)
            return nil
        }
    }
}
