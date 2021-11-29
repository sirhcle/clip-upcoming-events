//
//  MainViewController.swift
//  Clip Upcoming Events
//
//  Created by christian hernandez rivera on 28/11/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventVM = EventsViewModel()
    var dataEvents: [Events] = []
    
    var arrSorted: [Dictionary<String?, [Events]>.Element]!
    var arrOfKeys: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupView()
        self.bind()
    }
    
    
    func setupView() {
        self.eventVM.getAllEvents()
    }
    
    func bind() {
        self.eventVM.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.dataEvents = self?.eventVM.eventsModel ?? []
                self?.dataEvents = self?.dataEvents.sorted{ $0.start ?? "" < $1.start ?? "" } ?? []
                
                let eventsGrouped = Dictionary(grouping: self?.dataEvents ?? [], by: { $0.start?.components(separatedBy: ", ").first })
                
                self?.arrSorted = eventsGrouped.sorted(by: { ($0.0 ?? "").localizedStandardCompare(($1.0 ?? "")) == .orderedAscending })
                
                self?.arrSorted.forEach { (key: String?, value: [Events]) in
                    self?.arrOfKeys.append(key ?? "")
                }
                
                self?.tableView.reloadData()
                
            }
        }
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrOfKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSorted[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellEvents", for: indexPath) as! CellEvents
        cell.event = self.arrSorted[indexPath.section].value[indexPath.row]
        cell.sectionEvents = self.arrSorted[indexPath.section].value
        cell.currentIndex = indexPath.row
        cell.setupEvent()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = .lightGray
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width-10, height: headerView.frame.height)
        label.text = self.arrOfKeys[section]
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
}



