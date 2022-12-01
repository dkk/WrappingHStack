import XCTest

final class WrappingHStackExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testWrappingHStackPerformance() throws {
        measure(metrics: [XCTClockMetric()]) {
            let app = XCUIApplication()
            app.launchArguments = ["performanceTests_WHS"]
            app.launch()

            let elementsQuery = app.scrollViews.otherElements
            elementsQuery.buttons["Long WrappingHStack"].tap()
           // let longScroll = app.scrollViews.matching(identifier: "Long WrappingHStack scroll")
            let element = elementsQuery.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element
            while !elementsQuery.scrollViews.otherElements.staticTexts["end"].exists {
                element.swipeUp() // Not really necessary when working with VStack, but can be used to test LazyVStack
            }
        }
    }

    func testHStackPerformance() throws { // Testing similar functionality with HStack to see the impact
        measure(metrics: [XCTClockMetric()]) {
            let app = XCUIApplication()
            app.launchArguments = ["performanceTests_HS"]
            app.launch()

            let elementsQuery = app.scrollViews.otherElements
            elementsQuery.buttons["Long HStack"].tap()
           // let longScroll = app.scrollViews.matching(identifier: "Long WrappingHStack scroll")
            let element = elementsQuery.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element
            while !elementsQuery.scrollViews.otherElements.staticTexts["end"].exists {
                element.swipeUp() // Not really necessary when working with VStack, but can be used to test LazyVStack
            }
        }
    }
}
