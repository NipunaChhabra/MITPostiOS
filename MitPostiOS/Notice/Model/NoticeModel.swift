//
//  NoticeModel.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 04/07/21.
//

import Foundation

struct NoticeResponse : Codable{
    let status: String
    let data : [Notice]
}

struct Notice : Codable{
    let id: String?
    let title: String?
    let content: String?
    let date: String?
    let time: String?
    let imageLink: String?
    let pdfLink: String?
}
