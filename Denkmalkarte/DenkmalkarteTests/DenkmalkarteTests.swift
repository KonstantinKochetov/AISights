import XCTest
@testable import Denkmalkarte

class DenkmalkarteTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let view = MapScreenView.init(nibName: "DetailScreenView", bundle: Bundle(for: MapTabRouter.self))
        let presenter: MapScreenPresenterProtocol = MapScreenPresenter(view: view, router: MapTabRouter(navigationController: UINavigationController()), mapUseCases: assembler.resolve())
        view.presenter = presenter
        var string = "empty"
        presenter.getMapData(success: { result in
            string = result
        }, failure: { _ in

        })
        XCTAssertEqual(string, "map data from db")

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
