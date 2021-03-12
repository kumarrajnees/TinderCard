//
//  FavDataSourceTest.swift
//  TinderUserTests
//
//  Created by Rajneesh Kumar on 7/26/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import XCTest
@testable import TinderUser
class FavDataSourceTest: XCTestCase {

    var sut:FavouriteDataSource!
    var libtableview:UITableView!
    var favVC:FavListViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FavouriteDataSource()
        favVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "FavListViewController") as FavListViewController
        _ = favVC.view
        libtableview = favVC.tableview
        libtableview.dataSource = sut
        libtableview.delegate = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_tableView_sectionCount() {
        let sectionCount = libtableview.numberOfSections
        XCTAssertEqual(sectionCount, 1)
    }
    
    func test_numberforRows_toseecount() {
        sut.loadData()
        XCTAssertGreaterThanOrEqual(sut.fetchedResultsController.fetchedObjects?.count ?? 0, 5)
        libtableview.reloadData()
    }
    
    func test_cellforRowatIndexPath() {
        sut.loadData()
        libtableview.reloadData()
        let cell = libtableview.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is FavTableCell)
    }
    
}
