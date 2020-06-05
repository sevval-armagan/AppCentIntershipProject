//
//  FlickerImageVM.swift
//  AppCentIntershipProject
//
//  Created by Sevval Armagan on 5.06.2020.
//  Copyright © 2020 Sevval Armagan. All rights reserved.
//

import Foundation

protocol FlickerImageVMDelegate{
    func flickerImageRequestCompleted()
}

class FlickerImageVM{
    var flickerImageArray = [flickerImageModel]()
    var flickerImageArrayResult = [Photo]()
    var delegate: FlickerImageVMDelegate?
}


extension FlickerImageVM{
    func getImage(pageCount: Int, completed: @escaping ([Photo]) -> ()) {
        
        var request = URLRequest(url: URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=367692e746071c8d10b0de16854dd795&per_page=20&page=" + String(pageCount) + "&format=json&nojsoncallback=1")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = try? Data(contentsOf: request.url!)
        
        do {
            let json = try? JSONDecoder().decode(flickerImageModel.self, from: data!)
            flickerImageArray.append(json!)
            flickerImageArrayResult.append(contentsOf: (json?.photos?.photo)!)
        }
        self.delegate?.flickerImageRequestCompleted()
        completed(flickerImageArrayResult)
        
    }
    
    
    
}

