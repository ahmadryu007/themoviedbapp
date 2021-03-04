//
//  ReviewPresenter.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 5/3/21.
//

import Foundation

class ReviewPresenter: ReviewInteractorToPresenter {
    
    var view: ReviewPresenterToView?
    var interactor: ReviewPresenterToInteractor?
    var lastPageFetch = 0
    
    func reviewRequestSuccess(data: Reviews) {
        lastPageFetch = data.page
        view?.reviewLoaded(review: data)
    }
    
    func reviewRequestFail(code: String, message: String) {
        view?.showError(code: code, message: message)
    }
    
}

extension ReviewPresenter: ReviewViewToPresenter {
    
    func getReview(movieId: Int) {
        interactor?.getReviewRequest(movieId: movieId, page: lastPageFetch + 1)
    }
    
}
