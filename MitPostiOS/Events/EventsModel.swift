//
//  EventsModel.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 21/07/21.
//

import Foundation


class EventModel : Codable{
    let clubName:String?
    let clubUrl: String?
    let name:String?
    let description:String?
    let tags:String?
    let contactName:String?
    let contactNumber:String?
    let imageUrl:String?
    let startDate:String?
    let endDate:String?
    let registrationLink:String?
}
