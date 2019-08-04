//
//  YoutubeAPI.swift
//  ListeningDictionary
//
//  Created by Wi on 03/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation


class YoutubeAPI{
    var nextpageToken: String?
    var videoIds = [String]()
    
    func getYoutubeVideoIdInChenal(chenalId: String, apiKey: String){
        var url = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=\(chenalId)&key=\(apiKey)&maxResults=50"
        if let nextpageToken = nextpageToken {
            url += "&pageToken=\(nextpageToken)"
        }
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {return}
            do{
                let data = try JSONDecoder().decode(YoutubeData.self, from: data)
                self.videoIds += data.items.map{$0!.id.videoID}
                self.nextpageToken = data.nextPageToken
                print(self.videoIds, self.videoIds.count)
                self.getYoutubeVideoIdInChenal(chenalId: chenalId, apiKey: apiKey)
            }catch{
                print("aa",error.localizedDescription)
            }
            }.resume()
    }
}
