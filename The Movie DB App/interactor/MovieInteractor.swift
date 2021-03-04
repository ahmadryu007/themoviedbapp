//
//  MovieInteractor.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation
import Alamofire

class MovieInteractor: MoviePresenterToInteractor {
    
    var presenter: MovieInteractorToPresenter?
    
    func getMovieList(id: Int, page: Int) {
        let param = [
            "api_key" : Constants.apiKey,
            "page" : "\(page)",
            "with_genres" : "\(id)"
        ]
        
        AF.request(Constants.movieListPath, method: .get, parameters: param).response {
            response in
                switch response.result {
                    case .success(let data) :
                        guard let responseData = data else {
                            self.presenter?.genreListRequestFail(code: "parsing error", message: "data nil")
                            return
                        }
                        
                        do {
                            let movies = try JSONDecoder().decode(Movies.self, from: responseData)
                            self.presenter?.movieListRequestSuccess(data: movies)
                            
                        } catch {
                            print(error)
                            self.presenter?.genreListRequestFail(code: "parsing error", message: error.localizedDescription)
                        }
                    case .failure(let error) :
                        self.presenter?.genreListRequestFail(code: "\(String(describing: error.responseCode))", message: error.localizedDescription)
                }
        }
    }
    
}
