//
//  DetailMovieInteractor.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation
import Alamofire

class DetailMovieInteractor: DetailMoviePresenterToInteractor {
    
    var presenter: DetailMovieInteractorToPresenter?
    
    func getVideosRequest(movieId: Int) {
        
        let param = [
            "api_key" : Constants.apiKey
        ]
        
        let url = "\(Constants.videoListPath)\(movieId)/videos"
        
        AF.request(url, method: .get, parameters: param).response {
            response in
            switch response.result {
            case .success(let data) :
                guard let responseData = data else {
                    self.presenter?.videosRequestFail(code: "parsing error", message: "data nil")
                    return
                }
                
                do {
                    
                    let videos = try JSONDecoder().decode(Videos.self, from: responseData)
                    self.presenter?.videosRequestSuccess(data: videos)
                    
                } catch {
                    print(error)
                    self.presenter?.videosRequestFail(code: "parsing error", message: error.localizedDescription)
                }
            case .failure(let error) :
                self.presenter?.videosRequestFail(code: "\(String(describing: error.responseCode))", message: error.localizedDescription)
            }
        }
        
    }
    
    
}
