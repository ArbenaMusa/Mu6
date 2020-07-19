//
//  GameViewController.swift
//  Mu6
//
//  Created by Arbena on 18.7.20.
//  Copyright © 2020 am. All rights reserved.
//

import UIKit
import Speech

class GameViewController: UIViewController {

    // MARK: - Initializations
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var labelText = String()
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US")) //1
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    var lang: String = "en-US"
    
    var score: Int = 0
    var answer = String()
    var pickedNote = String()
    var times: Int = 0
    
    // MARK: - Game main
    override func viewDidLoad() {
        super.viewDidLoad()
        levelLabel.text = labelText
        callRandom(level: labelText)
        
        answerBtn.isEnabled = false
        speechRecognizer?.delegate = self as? SFSpeechRecognizerDelegate
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus { 
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            default:
                print("Something went wrong!")
            }
            
            OperationQueue.main.addOperation() {
                self.answerBtn.isEnabled = isButtonEnabled
            }
        }

    }
    
    // MARK: - Game action handler
    @IBAction func recordingBehavior(_ sender: Any) {
        if audioEngine.isRunning{
            audioEngine.stop()
            recognitionRequest?.endAudio()
            answerBtn.isEnabled = false
            checkNote(note: pickedNote, ans: answer)
            answerBtn.setTitle("Answer", for: .normal)
            answerLabel.text = ""
            callRandom(level: labelText)
            if(times > 1){
                scoreLabel.text = "Game ended with " + String(score) + " scores!"
                if(score == 0){
                    imageView.image = UIImage(named: "over")
                }
                else{
                    imageView.image = UIImage(named: "win")
                }
                answerBtn.setTitle("End it", for: .normal)
                answerBtn.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
            }
        } else {
            startRecording()
            answerBtn.setTitle("Submit", for: .normal)
            times = times + 1
        }
    }
    
    // MARK: - Speech Recognition
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("AudioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.answerLabel.text = result?.bestTranscription.formattedString
                self.answer = String(self.answerLabel.text!)
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                self.answerLabel.text = " "
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.answerBtn.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            answerBtn.isEnabled = true
        } else {
            answerBtn.isEnabled = false
        }
    }

    // MARK: - Random image picker
    
    func randomImagePicker(resource: String){
        let path = Bundle.main.path(forResource: resource, ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        
        let data = dictionary?.object(forKey: "Images") as! [String]
        pickedNote = data.randomElement()!
        imageView.image = UIImage(named: pickedNote)
    }
    
    func callRandom(level: String){
        if level == "Level 1"{
            randomImagePicker(resource: "SolNotesList")
        }
        else if level == "Level 2"{
            randomImagePicker(resource: "BassNotesList")
        }
    }
    
    // MARK: - Answer check
    
    func checkNote(note: String, ans: String){
        if (note[0].lowercased() == ans[0].lowercased()){
            score = score + 1
            scoreLabel.text = String(score)
        }
    }
    
    // MARK: - Play/Exit alert dialog
    @objc func openAlert(){
        let alertView = UIAlertController(title : "Game ended", message: "If u want to play again u surely can!", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Exit", style: .default, handler:{ (_) in  exit(0) }))
        alertView.addAction(UIAlertAction(title: "Play", style: .default, handler:{ (_) in
            self.dismiss(animated: true, completion: nil)
            self.presentMain()
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func presentMain(){
        let main = PlayViewController()
        self.present(main, animated: true, completion: nil)
    }
}

// MARK: - String indexing extension

extension StringProtocol{
    subscript(offset: Int) -> Character{
        self[index(startIndex, offsetBy: offset)]
    }
}
