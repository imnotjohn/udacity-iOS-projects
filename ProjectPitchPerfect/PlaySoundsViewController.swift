//
//  PlaySoundsViewController.swift
//  ProjectPitchPerfect
//
//  Created by J on 29/11/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var sliderValue: UISlider!
    
    //test
    @IBOutlet weak var ContainerStackView: UIStackView!
    @IBOutlet weak var voiceStackView: UIStackView!
    @IBOutlet weak var speedStackView: UIStackView!
    @IBOutlet weak var fxStackView: UIStackView!
    @IBOutlet weak var controlsStackView: UIStackView!
    
    var recordedAudioURL: NSURL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer:Timer!
    
    enum ButtonType: Int {
        case vader = 0, chipmunk = 1, snail = 2, rabbit = 3, echo = 4, reverb = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupAudio()
        //test
        setStackViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
        vaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    //test
    func setStackViewLayout() {
        let orientation = UIApplication.shared.statusBarOrientation
        
        if orientation.isPortrait {
            self.ContainerStackView.axis = .vertical
            self.setInnerStackViewsAxis(axisStyle: .horizontal)
        } else {
            self.ContainerStackView.axis = .horizontal
            self.setInnerStackViewsAxis(axisStyle: .vertical)
        }
    }
    
    //test
    func setInnerStackViewsAxis(axisStyle: UILayoutConstraintAxis) {
        self.voiceStackView.axis = axisStyle
        self.speedStackView.axis = axisStyle
        self.fxStackView.axis = axisStyle
        self.controlsStackView.axis = axisStyle
    }
    
    //test
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: ({ (context) -> Void in
            self.setStackViewLayout()
        }), completion: nil)
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .vader:
            playSound(rate: sliderValue.value, pitch:-1000)
        case .chipmunk:
            playSound(rate: sliderValue.value, pitch:1000)
        case .snail:
            playSound(rate: 0.5)
        case .rabbit:
            playSound(rate: 1.5)
        case .echo:
            playSound(rate: sliderValue.value, echo: true)
        case .reverb:
            playSound(rate: sliderValue.value, reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed (_ sender: UIButton) {
        stopAudio()
    }

}
