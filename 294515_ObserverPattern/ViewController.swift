import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var containverView: UIView!
    
    private let savedKey = "TabBarColor"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: -  *** Notification Center 通知のタイミングもあり、ここでは viewDidAppear(_:)で実行している
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: 既に色情報が保存されていれば、それを読み込む。
        if let savedColor = UserDefaults.standard.array(forKey: "TabBarColor") as? [Float] {
            redSlider.value = savedColor[0]
            greenSlider.value = savedColor[1]
            blueSlider.value = savedColor[2]
        } else {
            redSlider.value = 0.5
            greenSlider.value = 0.5
            blueSlider.value = 0.5
        }
        
        changeTabBackgroundColor(red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
        
        //　isTranslucet == false だと色の変更が効かない
        tabBarController?.tabBar.isTranslucent = true
        
        // UITabBar の背景を入れ替える
        tabBarController?.tabBar.backgroundImage = UIImage()
        
        // MARK: Container View に枠線を入れる
        containverView.layer.borderWidth = 2
        containverView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        changeTabBackgroundColor(red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
    }
    
    func changeTabBackgroundColor(red: Float, green: Float, blue: Float) {
        
        let color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        tabBarController?.tabBar.backgroundColor = color
        
        let userInfo = [
            "color" : color
        ]
        
        // MARK: NotificatonCenterで通知する
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorChangeValue"), object: nil, userInfo: userInfo)
        
        // UserDefaults で保存する
        let savedColor = [redSlider.value, greenSlider.value, blueSlider.value]
        UserDefaults.standard.setValue(savedColor, forKey: savedKey)
        
    }
}
