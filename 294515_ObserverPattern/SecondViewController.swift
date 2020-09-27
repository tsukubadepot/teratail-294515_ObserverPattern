import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: NavigationBarの背景を入れ替える（空の UIImage にする）
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // MARK: "colorChangeValue" で紐付けっれた通知を受け取ったら、クロージャ内を実行する
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "colorChangeValue"), object: nil, queue: nil) {
            [weak self] (notice) in
            
            if let color = notice.userInfo?["color"] as? UIColor {
                self?.navigationController?.navigationBar.backgroundColor = color
                
            }
        }
    
    // TODO: - 通知のタイミングによっては、ViewControllerからの通知が届かない可能性もあるので、初回のロード時だけは UserDefaults などからデータを得る方法も考えられる
    
    }
}
