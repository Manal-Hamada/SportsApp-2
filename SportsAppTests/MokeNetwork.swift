//
//  MokeNetwork.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.


import Foundation
import XCTest
@testable import SportsApp

final class MokeNetworkManager : XCTestCase {
    
    var fakeNetwork:FakeNetwork!
    
    override func setUpWithError() throws {
       
        fakeNetwork = FakeNetwork(shouldReturnError: false)
       
    }
    
    func testLeguesFromUrl(){
        
       fakeNetwork.fetchLegues(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler:  { legues in
           if legues == nil {
                XCTFail()
            }
            else {
                XCTAssert(legues?.result.count == 2 ,"loadded sucedded")
                //XCTAssertNotNil(employee)
            }
        })
    }
    
    func testTeamDetailsFromUrl(){
        
        fakeNetwork.fetchTeamDetails(url: "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=4&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0") { teams in
            if teams == nil {
                 XCTFail()
             }
             else {
                 XCTAssert(teams?.result?[0].teamKey == 1 ,"loadded sucedded")
                 //XCTAssertNotNil(employee)
             }
         }
        }
    
    func testLatestResultFromUrl(){
        fakeNetwork.fetchLeguesLatestResults(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2022-01-18&to=2023-01-18&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler:  { legues in
            if legues == nil {
                 XCTFail()
             }
             else {
                 XCTAssert(legues?.result.count == 2 ,"loadded sucedded")
                 //XCTAssertNotNil(employee)
             }
         })
       
        }
        
    func testUpComingEventsFromUrl(){
        fakeNetwork.fetchLeguesUpCommingEvents(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler:  { legues in
            if legues == nil {
                 XCTFail()
             }
             else {
                 XCTAssert(legues?.result.count == 2 ,"loadded sucedded")
                 //XCTAssertNotNil(employee)
             }
         })
       
        }
    func testLegueTeamsFromUrl(){
        fakeNetwork.fetchLegueTeams(url: "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=4&APIkey=a76d9e88b9432cadcc882ca7763f6fe791aea863aea1aad1a0e1f05d3227aea0", compilitionHandler:  { legues in
            if legues == nil {
                 XCTFail()
             }
             else {
                 XCTAssert(legues?.result.count == 2 ,"loadded sucedded")
                 //XCTAssertNotNil(employee)
             }
         })
       
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
