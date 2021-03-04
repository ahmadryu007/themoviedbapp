//
//  GenreInteractor.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation
import Alamofire

class GenreInteractor: GenrePresenterToInteractor {
    
    var presenter: GenreInteractorToPresenter?
    
    func getMovieGenreList() {
        
        let param = [
            "api_key" : Constants.apiKey
        ]
        
        AF.request(Constants.genreListPath, method: .get, parameters: param).response {
            response in
            switch response.result {
                case .success(let data) :
                    
                    guard let responseData = data else {
                        self.presenter?.genreListRequestFail(code: "parsing error", message: "data nil")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let genres = try decoder.decode(Genres.self, from: responseData)
                        
                        self.presenter?.genreListRequestSuccess(data: genres)
                        
                    } catch {
                        self.presenter?.genreListRequestFail(code: "parsing error", message: error.localizedDescription)
                    }
                    
                case .failure(let error) :
                    self.presenter?.genreListRequestFail(code: "\(String(describing: error.responseCode))", message: error.localizedDescription)
            }
        }
        
    }
    
}
