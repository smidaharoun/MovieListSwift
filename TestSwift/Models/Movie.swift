//
//  Movie.swift
//  TestSwift
//
//  Created by Haroun SMIDA on 2/8/18.

//  Copyright © 2018 sonic. All rights reserved.
//

import Foundation
struct Movie : Codable {
    
	let image : String?
	let title : String?
	let intro : String?
	let year : Int?
	let text : String?

	enum CodingKeys: String, CodingKey {
		case image = "image"
		case title = "title"
		case intro = "intro"
		case year = "year"
		case text = "text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		intro = try values.decodeIfPresent(String.self, forKey: .intro)
        year = try Int(values.decodeIfPresent(String.self, forKey: .year)!)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
