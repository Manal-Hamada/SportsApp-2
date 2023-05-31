//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Mac on 19/05/2023.
//

import XCTest
@testable import SportsApp


final class SportsAppTests: XCTestCase {

    var networkManager :NetworkManager!
    override func setUpWithError() throws {
       
        networkManager = NetworkManager()
    }

    func testDataFromUrl(){
        let myExpectation = expectation(description: "Waiting for API response")
        
        networkManager.fetchLegues(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler: { legues in
            
            if legues == nil {
                
                XCTFail()
            }
            else{
                
                XCTAssert(legues?.result[0].league_key == 4)
                myExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 7)
    }
    
    func testTeamDataFromUrl(){
        let myExpectation = expectation(description: "Waiting for API response")
        
        networkManager.fetchTeamDetails(url:"https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=4&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler: { teams in
            
            if teams == nil {
                
                XCTFail()
            }
            else{
                
                XCTAssert(teams?.result?[0].teamKey == 74)
                myExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10)
    }
    
    func testLatestResultsFromUrl(){
        let myExpectation = expectation(description: "Waiting for API response")
        
        networkManager.fetchLeguesLatestResults(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2022-01-18&to=2023-01-18&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler: { legues in
            
            if legues == nil {
                
                XCTFail()
            }
            else{
                
                XCTAssert(legues?.result[0].league_key == 205)
                myExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 7)
    }
    
    func testLegueTeamsFromUrl(){
        let myExpectation = expectation(description: "Waiting for API response")
        
        networkManager.fetchLegueTeams(url: "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=4&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler: { legues in
            
            if legues == nil {
                
                XCTFail()
            }
            else{
                
                XCTAssert(legues?.result[0].league_key != 205)
                myExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 7)
    }
    
    func testUpComingEventsFromUrl(){
         let myExpectation = expectation(description: "Waiting for API response")
        
        networkManager.fetchLeguesUpCommingEvents(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler: { legues in
            
            if legues == nil {
                
                XCTFail()
            }
            else{
                
                XCTAssert(legues?.result[0].event_date == "2023-05-24")
                myExpectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 7)
    }
    
    override func tearDownWithError() throws {
      
    }

    func testExample() throws {
      
    }

    func testPerformanceExample() throws {
        
        self.measure {
         
        }
    }

}
