//
//  DisplayViewController.swift
//  TestFacebook
//
//  Created by Anh Tuan on 6/12/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import RealmSwift
class DisplayViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    let realm = try! Realm()
    var listDisplay = [PostFBDB]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tbl.estimatedRowHeight = 100
        tbl.rowHeight = UITableViewAutomaticDimension
        self.loadData()
        // Do any additional setup after loading the view.
    }

    func loadData(){
        let a  = self.realm.objects(PostFBDB.self).sorted(byKeyPath: "created_time")
        for item in a {
            self.listDisplay.append(item)
        }
        self.tbl.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DisplayViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDisplay.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.lblDate.text = listDisplay[indexPath.row].created_time
        cell.lblContent.text = listDisplay[indexPath.row].message
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = listDisplay[indexPath.row].id
        let second = id.components(separatedBy: "_")
        let id2 = second[1]
        
        let url = "https://www.facebook.com/permalink.php?story_fbid=\(id2)&id=160115650810720"
        let link = URL.init(string: url)
        UIApplication.shared.open(link!, options: [:], completionHandler: nil)
    }
}
