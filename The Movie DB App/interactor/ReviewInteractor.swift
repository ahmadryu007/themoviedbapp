//
//  ReviewInteractor.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 5/3/21.
//

import Foundation
import Alamofire

class ReviewInteractor: ReviewPresenterToInteractor {
    
    var presenter: ReviewInteractorToPresenter?
    
    func getReviewRequest(movieId: Int, page: Int) {
        
        let param = [
            "api_key" : Constants.apiKey,
            "page" : "\(page)"
        ]
        
        let url = "\(Constants.reviewListPath)\(movieId)/reviews"
        
        AF.request(url, method: .get, parameters: param).response {
            response in
            switch response.result {
            case .success(let data) :
                guard let responseData = data else {
                    self.presenter?.reviewRequestFail(code: "parsing error", message: "data nil")
                    return
                }
                
                do {
                    let reviews = try JSONDecoder().decode(Reviews.self, from: responseData)
                    self.presenter?.reviewRequestSuccess(data: reviews)
                } catch {
                    self.presenter?.reviewRequestFail(code: "parsing error", message: error.localizedDescription)
                }
            case .failure(let error) :
                self.presenter?.reviewRequestFail(code: "\(String(describing: error.responseCode))", message: error.localizedDescription)
            }
        }
        
    }
    
}
