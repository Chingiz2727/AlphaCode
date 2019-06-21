//
//  ChooseTgisTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 5/10/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import UIKit

class ChooseTgisTableViewController: UITableViewController,UITextFieldDelegate {
    
    var item = [Item]()
    let textfield = UITextField()
    let cellid = "cellid"
    let cell2id = "cell2id"
    var proto_first : firs_place_add?
    var proto_second : second_place_add?
    var array = ["Выбрать местоположение на карте","Сохраненные места"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        
        tableView.register(ChoosePlaceTableViewCell.self, forCellReuseIdentifier: cell2id)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        view.addSubview(textfield)
        textfield.placeholder = "Место"
        textfield.textAlignment = .center
        return textfield
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        default:
            return 0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Search.Search(query: textfield.text!) { (module) in
            if let its = module.result?.items {
                self.item = its
                print(its.count)
                self.tableView.reloadData()
                
            }
        }
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let its = item[indexPath.row]
            
            let place_module = Place_Module(lat: its.point?.lat ?? 0, long: its.point?.lon ?? 0, name: its.caption ?? "")
            if proto_first != nil {
                self.proto_first?.first_place = place_module
                self.proto_first!.first_added()
            }
            if proto_second != nil {
                self.proto_second?.second_place = place_module
                self.proto_second!.second_added()
            }
            
        case 0:
            if indexPath.row == 0 {
                if proto_first != nil {
                    self.proto_first?.first_selected()
                }
                if proto_second != nil {
                    self.proto_second?.second_selected()
                    
                }
                
            }
        default:
            break
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return array.count
        default:
            return item.count
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cell2id, for: indexPath) as! ChoosePlaceTableViewCell
            cell.label.text = array[indexPath.row]
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid)
            cell?.textLabel?.text = item[indexPath.row].caption ?? ""
            return cell!
        }
    }
    
    
    
    
}
