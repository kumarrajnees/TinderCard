//
//  FavListViewController.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import UIKit

class FavListViewController: UIViewController {
    @IBOutlet weak var nofavdataAvailablelabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var dataSource: FavouriteDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    /// Configure tableview
    private func configureTableView() {
        dataSource.tableView = tableview
        tableview.dataSource = dataSource
        tableview.delegate = dataSource
        tableview.estimatedRowHeight = 40
        tableview.rowHeight = UITableView.automaticDimension
        dataSource.loadData()
    }
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nofavdataAvailablelabel.isHidden = tableview.numberOfRows(inSection: 0) > 0 ? true:false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
