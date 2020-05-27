//
//  ViewController.swift
//  tableViewJSON
//
//  Created by macOS on 4/24/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import UIKit
import Alamofire
import MagicMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var tbv:UITableView!
    
    
    var arrHero:[Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbv.dataSource = self
        tbv.delegate = self
        
        self.loadDataAF(getData: {value in
            self.arrHero = value
            self.tbv.reloadData()
        })
        
    }
    
    
    //load api thủ công cách 1
    //    func loadData1() {
    //                if let url = URL(string: "https://api.opendota.com/api/heroStats") {
    //                   URLSession.shared.dataTask(with: url) { data, response, error in
    //                     do {
    //                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any] {
    //
    //                            for i in json {
    //                                if let abc = i as? [String: Any] {
    //                                    print(abc)
    //
    //                                    if let localized_name = abc["localized_name"] as? String ,
    //                                    let primary_attr = abc["primary_attr"] as? String,
    //                                    let attack_type = abc["attack_type"] as? String,
    //                                    let legs = abc["legs"] as? Int,
    //                                    let img = abc["img"] as? String {
    //                                        let model:Hero = Hero.init(localized_name: localized_name, primary_attr: primary_attr, attack_type: attack_type, legs: legs, img: img)
    //                                        self.arrHero.append(model)
    //                                    }
    //                                }
    //                            }
    //                            DispatchQueue.main.async {
    //                                self.tbv.reloadData()
    //                            }
    //                        } else {
    //                         print("JSON is not an array of dictionaries")
    //                       }
    //                     } catch let error as NSError {
    //                       print(error)
    //                     }
    //
    //                   }.resume()
    //                }
    //            }
    
    
    //load api thủ công cách 2
    //    func loadData(completed: @escaping () -> () ) {
    //               let url = URL(string: "https://api.opendota.com/api/heroStats")
    //
    //            URLSession.shared.dataTask(with: url!){ (data,respone,error) in
    //
    //                if error == nil {
    //                    do {
    //                        self.arrHero = try JSONDecoder().decode([Hero].self, from: data!)
    //                        DispatchQueue.main.async {
    //                        completed()
    //                        }
    //                    } catch {
    //                        print("JSON error")
    //                    }
    //                }
    //            }.resume()
    //            }
    //}
    
    
    //load api bằng alamofire
    func loadDataAF(getData: @escaping (([Hero]) -> Void) ) {
        AF.request("https://api.opendota.com/api/heroStats").responseJSON{
            (response) in
            switch response.result {
            case .success(let value):
                //  print(value)
                if let arr = value as? [Any] {
                    print(arr.count)
                    var datas:[Hero] = []
                    for i in arr {
                        if let abc = i as? KeyValue {
                            print(abc)
                            let iObj = Hero(abc)
                            datas.append(iObj)
                        }
                    }
                    getData(datas)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}



//dataSource
extension ViewController:UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHero.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell1
        cell.lblName.text = arrHero[indexPath.row].localized_name.capitalized
        cell.lblText.text = arrHero[indexPath.row].attack_type.capitalized
        
        //load hinh tu tren mang
        let url1:URL = URL(string: "https://api.opendota.com"+arrHero[indexPath.row].img)!
        cell.img.load(url: url1)
        
        return cell
    }
}


//delegate
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


// load url tu tren mang
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
