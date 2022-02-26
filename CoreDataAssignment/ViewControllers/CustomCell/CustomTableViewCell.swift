import UIKit
import SwiftyMasonry

class CustomTableViewCell: UITableViewCell {

// MARK: PRIVATE LET DECLARATION:

let labTitle = UILabel()

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
 super.init(style: style, reuseIdentifier: reuseIdentifier)

   // Calling UI Element setting
   setBgColor()
   addingElemetsOnContentVw()
   addingElemetsProperties()

   // Calling Setting Constraints Method
   setTitleConstraints()
}

required init?(coder aDecoder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
}
override func awakeFromNib() {
        super.awakeFromNib()
}
}

private extension CustomTableViewCell {

// MARK: - Setting Background Theme

func setBgColor() {
       self.backgroundColor = .clear
       contentView.backgroundColor = .clear
}

// MARK: - Adding Elements On Content

func addingElemetsOnContentVw() {
        self.contentView.addSubview(labTitle)
}

// MARK: - Adding Properties On Elements

func addingElemetsProperties() {
        labTitle.textColor = .white
        // 0 number of lines for infinity max count.
        labTitle.numberOfLines = 0
        labTitle.textAlignment = .center
}

// MARK: - Setting Title Constraints

func setTitleConstraints() {
        labTitle.mas.makeConstraints(closure: { make in
            make.top.equalTo()(StringLiterals.Insects.topInset)
            make.left.equalTo()(StringLiterals.Insects.leftInset)
            make.right.equalTo()(StringLiterals.Insects.rightInset)
            make.bottom.equalTo()(StringLiterals.Insects.bottomInset)
    })
  }
}
