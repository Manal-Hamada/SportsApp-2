import XCTest

@testable import SportsApp

final class LeguesApiTest: XCTestCase {
    
    var sut : NetworkManager!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
 func testgetDataOverNetwork(){
        let expectation = XCTestExpectation(description: "Legues Downloaded")
        var responseResult : Legue?
        
        guard let bundle = Bundle.unitTest.path(forResource: "LegueApiResponse", ofType: "json")else{
            XCTFail("legues not found")
            return
        }
        sut.fetchLegues(url: bundle) { leguesResponse in
            responseResult = leguesResponse?.result.first
        }
        wait(for: [expectation],timeout: 15)
        
        XCTAssertNotNil(responseResult)
        
        
    }
    
}
