//
//  SocialModels.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/07/21.
//

import Foundation


struct Instagram : Codable{
    let _id : String
    let imageUrl: String?
    let caption: String?
    let link: String?
    let date: String?
    let __v: Int
}
