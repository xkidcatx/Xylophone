//
//  ViewController.swift
//  XylophoneNoStoryboard
//
//  Created by Eugene Kotovich on 06.04.2022.
//

import SwiftUI
import AVFoundation
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    var buttons: [UIButton] = []
    
//MARK: - Create Audio Player
    
    var player: AVAudioPlayer!
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
//MARK: - Create Keys
    
    func createKeys() {
        let keys = ["C","D","E","F","G","A","B"]
        for i in 0..<7 {
            let button = UIButton()
            button.setTitle(keys[i], for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            button.backgroundColor = UIColor.init(named: keys[i])
            button.layer.cornerRadius = 30
            button.addTarget(self, action: #selector(keyTapped), for: .touchUpInside)
            buttons.append(button)
            view.addSubview(button)
        }
    }
    
    @objc func keyTapped(_ sender: UIButton) {
        if let keys = sender.currentTitle { playSound(soundName: keys)}
        
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
    }
    
//MARK: - Itinialize UI
    
    func initialize() {
        
        createKeys()
        
        view.backgroundColor = UIColor.white
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalTo(50)
            make.bottom.equalTo(-50)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
        for i in buttons.indices {
            let button = buttons[i]
            button.snp.makeConstraints { make in
                make.width.equalTo((view.frame.width * (1 - CGFloat(i) * 0.035)))
            }
        }
        
    }

}

//MARK: - Set SwiftUI Prewiev

struct FlowProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let view = ViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> ViewController {
            return view
        }
        
        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
            
        }
        
    }
    
}
