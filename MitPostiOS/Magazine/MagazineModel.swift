//
//  MagazineModel.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 13/07/21.
//

import Foundation


struct Magazines: Codable{
    let status:String
    let data:[MagazineData]
}


struct MagazineData: Codable{
    let _id:String
    let title:String?
    let content:String?
    let date:String?
    let time:String?
    let imageLink:String?
    let pdfLink: String?
}
