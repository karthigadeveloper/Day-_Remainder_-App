//
//  ViewController.swift
//  simple_remainder_app
//
//  Created by Karthiga on 14/03/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
   var models = [remainder]()

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    @IBAction func DidTapAdd(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else{
            return
        }
        vc.title = "reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
            let new = remainder(title: title, date:date, idientifier: "id_\(title)")
            self.models.append(new)
            self.table.reloadData()
            
            
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.sound = .default
            content.body = body
            
            let targetDate = date
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
            let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if error != nil {
                    print("something")
                    
                }
            })
        }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func DidTapText() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,.sound], completionHandler: { success, error in
            if success{
                self.scheduleTest()
            }else if error != nil{
                        print("error occaured")
            }
        })
    }
    func  scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "welcome"
        content.sound = .default
        content.body = "Always welcome to my website. Always welcome to my website. Always welcome to my website."
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something")
                
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM,dd,yyyy"
        cell.detailTextLabel?.text = formatter.string(from: date)
        cell.textLabel?.font = UIFont(name: "Arial", size: 25)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

struct remainder{
    let title: String
    let date : Date
    let idientifier : String
    
}
