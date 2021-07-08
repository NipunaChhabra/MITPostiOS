//
//  ArticleModel.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 29/06/21.
//

import Foundation

struct ArticleModel : Codable{
    
    let _id : Int
    let category : String
    let timestamp : String
    let date : DateModel?
    let title : String?
    let featured_media :String?
    let link: String?
    let author: Author?
    let message : String?
}

struct DateModel: Codable{
    let year: String?
    let month: String?
    let day: String?
}

struct Author: Codable{
    let name: String?
    let url: String?
}
