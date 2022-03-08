import UIKit
import SwiftMessages

class WeatherDataListVC: UIViewController {

// MARK: - Private Lets

private var dataViewModelObject = DataViewModel()
private var getCurrentData = NSDictionary()
private var minutelyDataArr = [MinutelyData]()
private let coreManager = CoreDataManager()
let tableView = UITableView()
private let cellReuseIdentifier = "cell"
private var dataSource: TableViewDataSource<CustomTableViewCell, MinutelyData>!

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setNavBar()
    callToViewModelForUIUpdate()
  }
}

private extension WeatherDataListVC {
// MARK: - Setting Navigation Bar
func setNavBar() {
    navigationController?.navigationBar.barTintColor = StringLiterals.Colors.ColorNavBar
    navigationController?.navigationBar.isTranslucent = false
    self.title = "Current Weather Data"
    // Updating UI
    showUI()
}
// MARK: - Showing UI
func showUI() {
    self.view.backgroundColor = StringLiterals.Colors.ColorBg
    tableView.backgroundColor = .clear
    tableView.bounces = false
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = .white
    tableView.isHidden = true
    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    self.view.addSubview(tableView)
    // Setting Constraints for TableView
    tableView.mas.makeConstraints(closure: { make in
            make.top.equalTo()(view)
            make.left.equalTo()(view)
            make.right.equalTo()(view)
            make.bottom.equalTo()(view)
    })
}

// MARK: - Updating UI

func callToViewModelForUIUpdate() {
           // Binding of view with model
           self.dataViewModelObject.bindViewModelToController = {
           self.updateDataSource()
           }
}
// MARK: - Updating Data Table From Url

func updateDataSource() {
    getCurrentData = self.coreManager.getCurrentData()
    let minDataArr = self.getCurrentData["minutely"] as? NSArray
    do {
        self.minutelyDataArr = try DictionaryDecoder().decode([MinutelyData].self, from: minDataArr as Any )
    } catch {
    debugPrint(error)
    }
   reloadTable()
}
// MARK: - Reloading Table
func reloadTable() {
    // Initialising TableViewViewDataSource with its arguments having appropriate value and assigning to the dataSource.
    let currentDataArr = self.getCurrentData["current"] as? NSDictionary
       do {
        let topItems = try DictionaryDecoder().decode(JsonListData.self, from: currentDataArr as Any)
      self.dataSource = TableViewDataSource(cellIdentifier: cellReuseIdentifier,
                                            items: self.minutelyDataArr, topItems: topItems,
                                            configureCell: { (cell, row)  in
      cell.labTitle.text = "precipitation: \(row.precipitation ?? 0)"
      })
      DispatchQueue.main.async {
          self.tableView.dataSource = self.dataSource
          self.tableView.delegate = self.dataSource
          self.tableView.reloadData()
          self.tableView.isHidden = false
       }
      } catch {
       debugPrint(error)
      }

    guard self.minutelyDataArr.count != 0
       else {
           StringLiterals.SwiftMsg.status.configureContent(body: ("Data Not Found"))
           SwiftMessages.show(config: StringLiterals.SwiftMsg.statusConfig, view: StringLiterals.SwiftMsg.status)
           return
       }

    }
}
