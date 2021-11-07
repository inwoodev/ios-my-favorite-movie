//
//  ios_my_favorite_movieTests.swift
//  ios-my-favorite-movieTests
//
//  Created by 황인우 on 2021/11/01.
//

@testable import ios_my_favorite_movie
import Nimble
import XCTest

class ios_my_favorite_movieTests: XCTestCase {
    var mockURLSession: MockURLSession!
    var movieRespository: MovieRepository!
    var movieService: MovieService!
    var movieTableViewModel: MovieTableViewModel!
    var favoriteMovieTableViewModel: FavoriteMovieTableViewModel!
    override func setUpWithError() throws {
        // given 뷰가 로드되면
        mockURLSession = MockURLSession()
        movieRespository = MovieRepository(urlSession: mockURLSession, requestFactory: RequestFactory())
        movieService = MovieService(movieRepository: movieRespository)
        movieTableViewModel = MovieTableViewModel(movieService: movieService)
        favoriteMovieTableViewModel = FavoriteMovieTableViewModel()
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        movieService = nil
        movieRespository = nil
        movieService = nil
        movieTableViewModel = nil
    }

    func test_메인화면에서_사용자가_해리포터를_검색하면_해리포터관련_영화검색_결과를_받아오는지_체크() {
        // given
        let expectedFirstMetaData = StubMetaData.firstMovie
        let expectedSecondMetaData = StubMetaData.secondMovie
        
        // when 사용자가 해리포터 검색을 하면
        movieTableViewModel.handleSearchInput("해리포터")
        
        // then 해리포터 영화에 대한 tableView로 데이터를 불러온다
        guard let movieContainer = movieTableViewModel.movieInformation.value else { return }
        expect(movieContainer).toEventually(containElementSatisfying({ metaData in
            return metaData.title == expectedFirstMetaData.title
        }))
        
        expect(movieContainer).toEventually(containElementSatisfying({ metaData in
            return metaData.title == expectedSecondMetaData.title
        }, "예상된 영화 이름과 검색된 영화 이름이 동일할 것이다."))
        
        expect(movieContainer).toEventually(contain([expectedFirstMetaData, expectedSecondMetaData]), description: "총 두 개의 영화가 검색 될 것이다.")
    }

}
