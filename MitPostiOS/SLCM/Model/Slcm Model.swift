//
//  Slcm Model.swift
//  MitPostiOS
//
//  Created by Rohit Kuber on 01/08/21.
//

import Foundation


struct CaptchaModel : Codable{
    
    let success:Bool?
    let id: String?
    let imageUrl: URL?
    
}

struct SlcmResponse:Codable{
    let success:Bool
    let msg:String?
    let data:SlcmData?
}


struct SlcmData:Codable,Hashable{
    var attendance: [SlcmAttendanceData]?
    let name: String?
    let registration:String?
}

struct SlcmAttendanceData : Codable,Hashable{
    let year : String?
    let subjectCode : String?
    let subject: String?
    let semester: String?
    let totalClass: String?
    let daysPresent : String?
    let daysAbsent : String?
    let attendancePercentage: String?
}
