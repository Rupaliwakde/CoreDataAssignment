import UIKit

class TableViewDataSource<CELL: UITableViewCell, T>: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var cellIdentifier: String!
    // Created items as Generics as received data can be of any type.
    private var items: [T]!
    private var topItems: JsonListData
    private var indexPath = NSIndexPath()
    var configureCell: (CELL, T) -> Void = {_, _ in }
    // Initializer for storing the values.
    init(cellIdentifier: String, items: [T], topItems: JsonListData, configureCell: @escaping (CELL, T) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.topItems =  topItems
        self.configureCell = configureCell
    }
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: StringLiterals.Insects.topInset,
            y: StringLiterals.Insects.leftInset,
            width: tableView.frame.width,
            height: StringLiterals.Insects.heightInset))
        headerView.backgroundColor = StringLiterals.Colors.ColorNavBar
        let labTitle = UILabel()
        labTitle.textColor = .black
        labTitle.numberOfLines = 0
        labTitle.textAlignment = .center
        labTitle.frame = CGRect.init(x: StringLiterals.Insects.leftInset,
                                     y: StringLiterals.Insects.leftInset,
                                     width: tableView.frame.width-5,
                                     height: StringLiterals.Insects.heightInset)
        labTitle.text =
          "sunrise: \(self.topItems.sunrise ?? 0) \n"
        + "sunset: \(self.topItems.sunset ?? 0) \n temp: \(self.topItems.temp ?? 0) \n"
        + "humidity: \(self.topItems.humidity ?? 0) \n"
        + "uvi: \(self.topItems.uvi ?? 0) \n"
        + "clouds: \(self.topItems.clouds ?? 0) \n visibility: \(self.topItems.visibility ?? 0) "
        headerView.addSubview(labTitle)
       return headerView
    }
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        StringLiterals.Insects.heightInset
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL
        cell?.selectionStyle = .none
        let item = self.items[indexPath.row]
        self.configureCell(cell!, item)
        return cell!
    }
}
