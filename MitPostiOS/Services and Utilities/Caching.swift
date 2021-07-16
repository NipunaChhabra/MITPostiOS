//
//  Caching.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/07/21.
//

import Foundation
import Disk

 let articlesDictionaryCache = "articleDictionary.json"
 let noticesDictionaryCache = "noticesDictionary.json"
 let instagramDictionaryCache = "instagramDictionary.json"
 let magazineDictionaryCache = "magazineDictionary.json"
// let 

 

struct Caching{
    static let sharedInstance = Caching()
}
