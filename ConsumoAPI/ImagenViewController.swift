//
//  ImagenViewController.swift
//  ConsumoAPI
//
//  Created by mac16 on 26/10/21.
//

import UIKit

class ImagenViewController: UIViewController {

    @IBOutlet weak var imagenURLimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://cnnespanol.cnn.com/wp-content/uploads/2021/10/image008-1.jpg?quality=100&strip=info"){
            
            DispatchQueue.global().async { [weak self] in
                
                if let data = try? Data(contentsOf: url){
                    //obj del tipo image a partir de una imagen
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self?.imagenURLimage.image = image
                        }
                        }
                    }
                }
            
        }
    }
    

   

}
