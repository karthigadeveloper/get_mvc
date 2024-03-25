//
//  ViewController.swift
//  get
//
//  Created by apple on 8/18/23.
//

import UIKit
struct root :Codable{
    let login:String?
    let id:Int?
    let node_id: String?
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "one",for: indexPath)as! TableViewCell
        cell.lbl1.text = json?[indexPath.row].login
        cell.lbl2.text = json?[indexPath.row].node_id
        cell.lbl3.text = json?[indexPath.row].id?.description
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
       
    }
    var json :[root]?
    
    func getdata(){
        let url = URL(string:"https://api.github.com/users/hadley/orgs")
        let task = URLSession.shared.dataTask(with: url!){
            ( data, responds, error) in
            do{
                let content = try? JSONDecoder().decode([root].self, from: data!)
                self.json = content
                DispatchQueue.main.async {
                    self.tableview.reloadData() //again and again reload 
                }
            }catch{
                print(error)
            }
            
        }
        task.resume()//suspended.
    }
}

