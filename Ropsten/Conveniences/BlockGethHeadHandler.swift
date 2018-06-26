//
//  BlockGethHeadHandler.swift
//  Ropsten
//
//  Created by Isaías Lima on 25/06/2018.
//  Copyright © 2018 Isaías. All rights reserved.
//

import UIKit
import Geth

class BlockGethHeadHandler: NSObject, GEGethNewHeadHandlerProtocol {

//    - (instancetype)initWithRef:(id)ref;
//    - (void)onError:(NSString*)failure;
//    - (void)onNewHead:(GEGethHeader*)header;

    func onError(_ failure: String!) {
        print(#function, "Error :" + failure)
    }

    func onNewHead(_ header: GEGethHeader!) {
        print(#function, "# \(header.getNumber()) : \(header.getHash().getHex()) \n")
    }
}
