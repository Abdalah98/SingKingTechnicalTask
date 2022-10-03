//
//  SearchCell.swift
//  Breaking Bad
//
//  Created by Abdallah on 6/16/21.
//

import UIKit

class CharactersListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSearch: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func layoutSubviews() {
          super.layoutSubviews()
          contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom:5, right: 10))
      }
   
    var characters: CharactersListCellViewModel?{
        didSet{
            name.text = characters?.name
            imageSearch.loadImageUsingCacheWithURLString(characters?.image ?? "", placeHolder: UIImage(named: "no_image_placeholder"))
        }
    }
    
}
