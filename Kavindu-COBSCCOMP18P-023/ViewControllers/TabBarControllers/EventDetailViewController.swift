

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sDateTxt: UILabel!
    @IBOutlet weak var eDateTxt: UILabel!
    @IBOutlet weak var locationTxt: UILabel!
    
   
    
    var event:Event?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if(event != nil){
           
            
            seledtedDataLoad(event:event!)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func seledtedDataLoad(event:Event){
        guard let url=URL(string: event.displayImageUrl ?? "") else{return}
        eventImage.kf.setImage(with: url)
        titleLbl.text=event.title
        
        guard let startingDate=event.startingdate else {return}
        guard let endDate=event.endDate else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        guard let now = dateFormatter.date(from: startingDate) else {return}
        dateFormatter.dateFormat = "MMM"
        var nameOfMonth = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "dd"
        var dayOfMonth = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "EEEE"
        var nameOfDay = dateFormatter.string(from: now)
        let SDAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppColors.black, .font: UIFont.systemFont(ofSize: 18)]
        guard let sTime = event.startTime=="" ?"6.0":event.startTime  else{return}
        guard let eTime = event.endTime=="" ?"6.0":event.endTime  else{return}
        let firstString = NSMutableAttributedString(string: nameOfDay+","+nameOfMonth+" "+dayOfMonth+"    "+sTime+"0 -"+eTime+"0", attributes: SDAttributes)
        
        
        
        sDateTxt.attributedText=firstString
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        guard let enow = dateFormatter.date(from: endDate) else {return}
        dateFormatter.dateFormat = "MMM"
        nameOfMonth = dateFormatter.string(from: enow)
        dateFormatter.dateFormat = "dd"
        dayOfMonth = dateFormatter.string(from: enow)
        dateFormatter.dateFormat = "EEEE"
        nameOfDay = dateFormatter.string(from: enow)
        let EDAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: AppColors.black, .font: UIFont.systemFont(ofSize: 18)]
        let secondString = NSMutableAttributedString(string: nameOfDay+","+nameOfMonth+" "+dayOfMonth, attributes: EDAttributes)
        eDateTxt.attributedText=secondString
        locationTxt.text=event.location ?? "NIBM"

        
        
    }

}
