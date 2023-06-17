//
//  productListViewCell.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 17/6/23.
//

import UIKit

class productListViewCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitelLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration(product: ProductModel){
        productTitelLabel.text = product.title
        productCategoryLabel.text = product.category
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        productImageView.setImage(with: product.image)
    }
    
}
