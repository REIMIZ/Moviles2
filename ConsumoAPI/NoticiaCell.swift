//
//  NoticiaCell.swift
//  ConsumoAPI
//
//  Created by mac16 on 26/10/21.
//

import UIKit

class NoticiaCell: UITableViewCell {

    @IBOutlet weak var imagenNoticiaImage: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
