


import UIKit
class Header: UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //label.text = "Categories"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.tintColor = .label
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    func labelText(text:String){
        self.label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
