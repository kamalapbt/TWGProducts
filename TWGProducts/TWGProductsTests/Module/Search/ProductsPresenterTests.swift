//
//  ProductsPresenterTests.swift
//  TWGProductsTests
//
//  Created by Kamala Tennakoon on 3/10/21.
//

import XCTest

@testable import TWGProducts


class ProductsPresenterTests: XCTestCase {
    var sut: ProductsPresenter?
    var mockView: MockProductsViewController?
    var mockInteractor: MockProductsInteractor?
    var mockRouter: MockProductsRouter?
    
    /* We need to do a lot of setup here to make sure all
     out dependcies are loaded before the tests are run.*/
    override func setUp() {
        sut = ProductsPresenter()
        mockView =  MockProductsViewController()
        mockInteractor = MockProductsInteractor()
        
        mockRouter = MockProductsRouter()
        mockInteractor?.output = sut
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
        
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testDidRecieveData() {
        let mockData: SearchResult = SearchResult(result: [], hitCount: "xx", found: "y")
        sut?.didRecieveData(with: .success(mockData))
        XCTAssertTrue(mockView!.isSuccessCalled, "didRecieveData for success")
        
        sut?.didRecieveData(with: .failure(ApiError.invalidRequest))
        XCTAssertTrue(mockView!.isErrorCalled, "didRecieveData for error")
        
    }
    
    func testOnSearchProducts() {
        sut?.onSearchProducts(forText: "")
        XCTAssertTrue(mockInteractor!.isSearchCalled, "onSearchProducts with empty text")
        
        sut?.onSearchProducts(forText: "xxx")
        XCTAssertTrue(mockInteractor!.isSearchCalled, "onSearchProducts with non-empty text")
    }
    
    func testOnSelectProduct() {
        sut?.onSelectProduct(withItem: Item(description: "des", products: []))
        XCTAssertFalse(mockRouter!.isPresentDetailCalled, "onSelectProduct without any products")
        
        sut?.onSelectProduct(withItem: Item(description: "des", products: [Product(withBarcode: "as", description: nil, imageUrl: nil, price: nil)]))
        XCTAssertTrue(mockRouter!.isPresentDetailCalled, "onSelectProduct with products")
    }
    
    class MockProductsViewController: ProductsViewController {
        var isSuccessCalled = false
        var isErrorCalled = false
        
        override func didRecieveData(with data: SearchResult?){
            isSuccessCalled = true
        }
        
        override func didRecieveError(with data: Error){
            isErrorCalled = true
        }
    }
    
    class MockProductsInteractor: ProductsInteractor {
        var isSearchCalled = false
        override func searchProducts(forText text: String) {
            isSearchCalled = true
        }
    }
    
    class MockProductsRouter: ProductsRouter {
        var isPresentDetailCalled = false
        override func presentDetail(forEntity item: Product) {
            isPresentDetailCalled = true
        }
    }
}
