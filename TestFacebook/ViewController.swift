//
//  ViewController.swift
//  TestFacebook
//
//  Created by Anh Tuan on 6/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import FacebookCore
import SwiftyJSON
import Alamofire
import RealmSwift

class PostFB {
    var created_time : String
    var message : String
    var id : String
    init(json : JSON) {
        self.created_time = json["created_time"].stringValue
        self.message = json["message"].stringValue
        self.id = json["id"].stringValue
    }
}

class PostFBDB: Object {
    dynamic var created_time = ""
    dynamic var message = ""
    dynamic var id = ""
}

class ViewController: UIViewController {
    let realm = try! Realm()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request(url: "https://graph.facebook.com/v2.9/160115650810720/posts?access_token=EAACEdEose0cBAMtbcH3lLMzCNT7KigDEEvrZAW7g0nl6IWswB1d4e9OzCnDQYZAlUdtWkplpvV9kQpV6rtNtnXT6kMHCsZBI8lBw1QRjf8y6nVIQD8RC7MAB8Da5XX618gGiC1tDBM3rcfjerpZBr0kWbqPi9VcEUUmopdQNYEifgJ63Kdh11wEDcBHTiJkZD&pretty=0&limit=25&after=Q2c4U1pXNTBYM0YxWlhKNVgzTjBiM0o1WDJsa0R5TXhOakF4TVRVMk5UQTRNVEEzTWpBNk5EWTNOVEV4TWpVeE16YzVOREF4TWprME9ROE1ZAWEJwWDNOMGIzSjVYMmxrRHg4eE5qQXhNVFUyTlRBNE1UQTNNakJmT0RFeU5USTBNVFU0T1RBek1UazJEd1IwYVcxbEJsa2ZABZAklC")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func request(url : String) {
        var list = [PostFB]()
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            let json = JSON.init(data: response.data!)
            let data = json["data"].arrayValue
            for item in data {
                let postobj = PostFB(json: item)
                list.append(postobj)
                let postFBDB = PostFBDB()
                postFBDB.created_time = postobj.created_time
                postFBDB.message = postobj.message
                postFBDB.id = postobj.id
                try! self.realm.write {
                    self.realm.add(postFBDB)
                }

            }
            NSLog("\(list.count)")
            let paging = json["paging"]["next"].stringValue
            self.request(url: paging)
        }
    }
}



