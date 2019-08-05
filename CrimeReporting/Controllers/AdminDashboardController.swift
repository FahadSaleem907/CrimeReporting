import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import Charts

class AdminDashboardController: UIViewController
{
    // MARK: - Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let reportServices = reportFunctions()
    
    // MARK: - Variables
    var layoutSize:CGSize?
    var tmpDic = [String:Int]()
    var reportsList = [Report?]()
    var userReports = [Report?]()
    {
        didSet
        {
            reportNumbers.reloadData()
        }
    }

    // MARK: - Actions
    
    @IBAction func logout(_ sender: UIButton)
    {
        handleLogout()
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var reportNumbers: UICollectionView!
    @IBOutlet weak var chartView: PieChartView!
    
    // MARK: - Functions
    
    @objc func handleLogout()
    {
        do
        {
            try Auth.auth().signOut()
            
            //let loginController = MainViewController()
            print(Auth.auth().currentUser?.uid)
            
            self.dismiss(animated: true, completion: nil)
        }
        catch let logoutError
        {
            print(logoutError)
        }
    }
    
    func getSize()
    {
        layoutSize = reportNumbers.frame.size
    }
    
    func getData(completion:@escaping([Report?])->Void)
    {
        reportServices.adminViewReports
            {
                (report) in
                
                self.delegate.currentUser!.reports.removeAll()
                self.reportsList = report
                
                self.delegate.currentUser?.reports = self.reportsList
                completion(self.delegate.currentUser!.reports)
        }
    }
    
    func getPieChart()
    {
        tmpDic.removeAll()
        for i in userReports
        {
            for j in reportServices.reportTypes
            {
                if i?.reportType == j
                {
                    if tmpDic.keys.contains(i!.reportType) == true
                    {
                        var tmpVal = tmpDic["\(i!.reportType)"]
                        tmpVal = tmpVal! + 1
                        tmpDic.updateValue(tmpVal!, forKey: "\(i!.reportType)")
                    }
                    else
                    {
                        tmpDic.updateValue(1, forKey: i!.reportType)
                    }
                }
            }
        }
        let tmpTypes = [String](tmpDic.keys)
        let tmpArr2 = [Int](tmpDic.values)
        let ys1 = tmpArr2.map { x in return Double(x) /*( Double(x) / Double(userReports.count) ) * 360.0*/ }
        
        let yse1 = ys1.enumerated().map { x, y in return PieChartDataEntry(value: y, label: tmpTypes[x]) }
        
        let data = PieChartData()
        let ds1 = PieChartDataSet(entries: yse1, label: "Hello")
        let ds2 = PieChartDataSet(entries: yse1, label: "Color Keys")
        
        
        //ds1.colors = ChartColorTemplates.vordiplom()
        //ds2.colors = ChartColorTemplates.colorful()
        
        var colors: [UIColor] = []
        
        for i in 0..<reportServices.reportTypes.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(100))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        ds2.colors = colors
        
        data.addDataSet(ds2)
        //data.addDataSet(ds1)
        
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        let centerText: NSMutableAttributedString = NSMutableAttributedString(string: "Details\nCrime Reports")
        centerText.setAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 15.0)!, NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, centerText.length))
        centerText.addAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 13.0)!, NSAttributedString.Key.foregroundColor: UIColor.gray], range: NSMakeRange(10, centerText.length - 10))
        centerText.addAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-LightItalic", size: 13.0)!, NSAttributedString.Key.foregroundColor: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)], range: NSMakeRange(centerText.length - 21, 8))
        centerText.addAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-LightItalic", size: 13.0)!, NSAttributedString.Key.foregroundColor: UIColor(red: 51 / 255.0, green: 181 / 255.0, blue: 229 / 255.0, alpha: 1.0)], range: NSMakeRange(centerText.length - 13, 13))
//        centerText.addAttributes([NSAttributedString.Key.foregroundColor : whiteColor], range: NSRange(location: 0, length: 7) )
        
        self.chartView.centerAttributedText = centerText
        //self.chartView.drawHoleEnabled = false
        self.chartView.data = data
        self.chartView.holeColor = UIColor.clear
        self.chartView.drawEntryLabelsEnabled = false
        self.chartView.chartDescription?.text = ""
        //self.chartView.
        //self.chartView.chartDescription?.text = "Reports Activity"
    }
    override func viewDidLayoutSubviews()
    {
        getSize()
        self.chartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData
            { (report) in
            self.userReports.removeAll()
            self.userReports = report
            //self.checkReport()
            self.getPieChart()
        }
        reportNumbers.reloadData()
        
        
        //getSize()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportNumbers.delegate      = self
        reportNumbers.dataSource    = self
        
        getSize()
        
        //let tmpArray1 = [1,2,3,4,5]
        
    }
}

extension AdminDashboardController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return layoutSize!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = reportNumbers.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdminDashboardCollectionViewCell
        
        func setBackgroundColor()
        {
            cell.mainCellView.frame.size = layoutSize!
            cell.mainCellView.backgroundColor = .clear
            
            if indexPath.item == 0
            {
                cell.reportCount.text = String(delegate.currentUser!.reports.count)
                cell.reportText.text  = "Total Reports"
                cell.backgroundImg.image = UIImage.init(named: "blue1")
            }
            if indexPath.item == 1
            {
                var tmpArray = [Report?]()
                
                for i in delegate.currentUser!.reports
                {
                    if i?.isPending == true
                    {
                        tmpArray.append(i)
                    }
                }
                
                cell.reportCount.text = String(tmpArray.count)
                cell.reportText.text  = "Pending Reports"
                cell.backgroundImg.image = UIImage.init(named: "yellow")
            }
            if indexPath.item == 2
            {
                var tmpArray = [Report?]()
                for i in delegate.currentUser!.reports
                {
                    if i?.isInProgress == true
                    {
                        tmpArray.append(i)
                    }
                }
                
                cell.reportCount.text = String(tmpArray.count)
                cell.reportText.text = "Reports In Progress"
                cell.backgroundImg.image = UIImage.init(named: "orange")
                
            }
            if indexPath.item == 3
            {
                var tmpArray = [Report?]()
                for i in delegate.currentUser!.reports
                {
                    if i?.isCompleted == true
                    {
                        tmpArray.append(i)
                    }
                }
                cell.reportCount.text = String(tmpArray.count)
                cell.reportText.text = "Completed Reports"
                cell.backgroundImg.image = UIImage.init(named: "green1")
            }
        }
        
        setBackgroundColor()
        
        return cell
    }
}
