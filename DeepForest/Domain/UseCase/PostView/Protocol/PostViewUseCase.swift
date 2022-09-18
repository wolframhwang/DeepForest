//
//  PostViewUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation
import RxSwift

protocol PostViewUseCase {
    var navigationTitleObservable: BehaviorSubject<String> { get }
    
    var titleObservable: BehaviorSubject<String> { get }
    var contentObservable: PublishSubject<String> { get }
    var writerObservable: PublishSubject<String> { get }
    var dateObservable: PublishSubject<String> { get }
    
    var imageArray: PublishSubject<[ImageArrayResponseDTO]?> { get }
    //
    func postComment(_ content: String) -> Observable<String?>
    func fetchPost() -> Observable<String?>
    func fetchComments() -> Observable<[CommentItem]>
}
