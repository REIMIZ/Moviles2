//
//  NoticiasViewController.swift
//  ConsumoAPI
//
//  Created by marco rodriguez on 18/10/21.
//

import UIKit
import SafariServices
// MARK: - Estructuras
struct Noticias: Codable {
    var articles: [Noticia]
}

struct Noticia: Codable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var url: String
}

class NoticiasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var noticias = [Noticia]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(noticias[indexPath.row].url)
        
        if let url = URL(string: noticias[indexPath.row].url){
            let safariVC = SFSafariViewController(url: url)
            
            present(safariVC, animated: true, completion: nil)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaCell
        celda.tituloLabel.text = noticias[indexPath.row].title
        celda.descripcionLabel.text = noticias[indexPath.row].description
        
        if let url = URL(string: noticias[indexPath.row].urlToImage ?? "https://cnnespanol.cnn.com/wp-content/uploads/2021/10/image008-1.jpg?quality=100&strip=info"){
            
            DispatchQueue.global().async { [weak self] in
                
                if let data = try? Data(contentsOf: url){
                    //obj del tipo image a partir de una imagen
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            celda.imagenNoticiaImage.image = image
                            //self?.imagenURLimage.image = image
                        }
                        }
                    }
                }
            
        }
        
        
        
        return celda
    }
    

    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registar la nueva celda
        tablaNoticias.register(UINib(nibName: "NoticiaCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                print("Listo para llamar a parse!")
             parse(json: data)
            }
        }


    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("Se llamo parse y creo decoder")
        if let jsonPeticion = try? decoder.decode(Noticias.self, from: json) {
            print("Json Petitions: \(jsonPeticion.articles.count)")
            noticias = jsonPeticion.articles
            print("news: \(noticias.count)")
            tablaNoticias.reloadData()
        }
    }

    

    

}
