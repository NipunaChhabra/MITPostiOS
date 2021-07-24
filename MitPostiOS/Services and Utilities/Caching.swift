//
//  Caching.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/07/21.
//

import Foundation
import Disk

 let articlesCache = "article.json"
 let noticesCache = "notices.json"
 let instagramCache = "instagram.json"
 let magazineCache = "magazine.json"
// let 

 

struct Caching{
    static let sharedInstance = Caching()
    
    func saveArticlesToCache(article: [ArticleModel]){
        do{
            try Disk.save(article, to: .caches, as: articlesCache)
        }catch let error{
            print(error)
        }
    }
    
    func saveNoticesToCache(notices: [Notice]){
        do{
            try Disk.save(notices, to: .caches, as: noticesCache)
        }catch let error{
            print(error)
        }
    }
    
    func saveMagazinesToCache(magazines: [MagazineData]){
        do{
            try Disk.save(magazines, to: .caches, as: magazineCache)
        }catch let error{
            print(error)
        }
    }
    
    func saveInstagramDataToCache(instagramData: [Instagram]){
        do{
            try Disk.save(instagramData, to: .caches, as: instagramCache)
        }catch let error{
            print(error)
        }
    }
    
    
}
