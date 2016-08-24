//
//  ViewController.swift
//  Quizzy
//
//  Created by Eoin Molloy on 26/12/2015.
//  Copyright © 2015 Eoin Molloy. All rights reserved.
//

import UIKit
import Social
import AudioToolbox

struct Question {
    var question : String!
    var answers : [String]!
    var answer : Int!
}

class ViewController: UIViewController {
    

    @IBOutlet weak var Label: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var LabelEnd: UILabel!
    @IBOutlet var Next: UIButton!
    
    var CorrectAnswer = String()
    var CorrectSound: SystemSoundID!
    var WrongSound: SystemSoundID!
    
    
//    @IBAction func tweetButton(_ sender: AnyObject) {
//        
//        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
//            let tweetController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//            tweetController?.setInitialText("I scored \(highScore) in Quizzy, can you beat me ?")
//            
//            self.present(tweetController!, animated: true, completion: nil)
//        }
//        else {
//            let alert  = UIAlertController(title: "Accounts", message: "You are not logged in to a twitter account, please login", preferredStyle: UIAlertControllerStyle.alert)
//            
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: {
//                
//                (UIAlertAction) in
//            let URLSettings = URL(string: UIApplicationOpenSettingsURLString)
//            
//                if let url = URLSettings {
//                    UIApplication.shared.openURL(url)
//                }
//            
//            
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
    func createSounds(){
        var soundID: SystemSoundID = 0
        
        var soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "correct" as CFString!, "wav" as CFString!, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        CorrectSound = soundID
        soundID += 1
        
        soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "wrong" as CFString!, "wav" as CFString!, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        WrongSound = soundID
        soundID += 1
    }
    
//    weak var Score: UILabel!
//    
//    weak var Highscore: UILabel!
    
    var Questions = [Question]()
    var questionNumber = Int()
    var answerNumber = Int()
    var scoreNum = 0
//    var highScore = 0
//    func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Questions = [Question(question: "Euro 2016 winner ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
                     
                     Question(question: "a cup of 〜", answers: ["コップ1杯の〜", "帽子1個の〜", "コイン1枚の", "カッター1本の〜"], answer: 0),
                     
                     Question(question: "a few 〜", answers: ["たくさんの〜", "同じくらい〜", "少しの〜", "1本の〜"], answer: 2),
                     
                     Question(question: "a little", answers: ["少しの", "ほとんどない", "何度も", "いつか"], answer: 0),
                     
                     Question(question: "a lot", answers: ["1本", "たくさん", "1日中", "1人"], answer: 1),
                     
                     Question(question: "a lot of 〜", answers: ["〜の間ずっと", "〜とは異なっている", "〜に遅れる", "たくさんの〜"], answer: 3),
                     
                     Question(question: "a pair of 〜", answers: ["〜の前で", "〜の外に", "1組の〜", "ほとんどの〜"], answer: 2),
                     
                     Question(question: "a part of 〜", answers: ["〜の1部", "〜の方へ", "〜の中へ", "〜の多く"], answer: 0),
                     
                     Question(question: "a piece of 〜", answers: ["〜が原因で", "〜の代わりに", "〜の世話をする", "1片の〜"], answer: 3),
                     
                     Question(question: "after school", answers: ["卒業", "放課後", "就職", "進学"], answer: 1),
                     
                     Question(question: "again and again", answers: ["何度も", "2回目", "一所懸命", "1日中"], answer: 0),
                     
                     Question(question: "agree with 〜", answers: ["〜といっしょに行く", "〜を持っている", "〜をお願いする", "〜に同意する"], answer: 3),
                     
                     Question(question: "all day", answers: ["1日中", "ところで", "今後", "将来"], answer: 0),
                     
                     Question(question: "all night", answers: ["毎晩", "夜遅く", "夜中", "一晩中"], answer: 3),
                     
                     Question(question: "all over 〜", answers: ["〜以上", "〜中で", "〜の全部", "〜の間ずっと"], answer: 1),
                     
                     Question(question: "all the time", answers: ["一生", "その間ずっと", "昔は", "毎日"], answer: 2),
                     
                     Question(question: "and so on", answers: ["さらに", "以上", "〜など", "その上"], answer: 2),
                     
                     Question(question: "around the world", answers: ["世界中", "世界一周旅行", "世の中では", "地球の自転"], answer: 0),
                     
                     Question(question: "arrive at 〜", answers: ["〜でライブを見る", "〜で過ごす", "〜に着く", "〜に賛成する"], answer: 2),
                     
                     Question(question: "as 〜 as…", answers: ["〜と…の両方", "…するやいなや〜", "〜と…を合わせて", "…と同じくらい〜"], answer: 3),
                     
                     Question(question: "ask 〜 for …", answers: ["…について〜に尋ねる", "…のために〜をする", "…に〜を頼む", "…の方へ〜を持っていく"], answer: 2),
                     
                     Question(question: "ask 〜 to …", answers: ["〜に…するように頼む", "〜に…を渡す", "〜に…することをすすめる", "〜に…をもたらす"], answer: 0),
                     
                     Question(question: "at first", answers: ["1塁ベース", "速く", "早起き", "最初は"], answer: 3),
                     
                     Question(question: "at the age of 〜", answers: ["〜を経由して", "〜の段階で", "〜の向こう側に", "〜歳の時に"], answer: 3),
                     
                     Question(question: "at the same time", answers: ["いつか", "数分で", "同時に", "長い間"], answer: 2),
                     
                     Question(question: "be able to 〜", answers: ["〜しなければならない", "〜するつもりである", "〜すべきである", "〜することができる"], answer: 3),
                     
                     Question(question: "be afraid of 〜", answers: ["〜をこわがる", "〜に親切である", "〜について知っている", "〜の見方である"], answer: 0),
                     
                     Question(question: "be careful", answers: ["気をつける", "礼儀正しくする", "静かにする", "世話をする"], answer: 0),
                     
                     Question(question: "be different from 〜", answers: ["〜を難しいと思う", "〜とは異なっている", "〜に興味がある", "〜で有名である"], answer: 1),
                     
                     Question(question: "be full of 〜", answers: ["〜に無知である", "〜でいっぱいである", "〜のお陰である", "〜に注意する"], answer: 1),
                     
                     Question(question: "be going to 〜", answers: ["〜しなければならない", "〜すべきである", "〜することができる", "〜するつもりである"], answer: 3),
                     
                     Question(question: "be glad to 〜", answers: ["〜を知っている", "〜してうれしく思う", "〜しなければならない", "〜してもよい"], answer: 1),
                     
                     Question(question: "be good at 〜", answers: ["〜をよく知っている", "〜が得意である", "〜の準備ができている", "〜のことを聞く"], answer: 1),
                     
                     Question(question: "be in trouble", answers: ["困難を克服する", "原因が分かる", "困っている", "遅刻する"], answer: 2),
                     
                     Question(question: "be interested in 〜", answers: ["〜に興味がある", "〜で知られている", "〜に入ってくる", "〜しようとしてみる"], answer: 0),
                     
                     Question(question: "be known to 〜", answers: ["〜しなければならない", "〜に行ったことがある", "〜で知られている", "〜を覚えておく"], answer: 2),
                     
                     Question(question: "be late for 〜", answers: ["〜を忘れる", "〜に遅れる", "〜を誇りに思う", "〜に驚く"], answer: 1),
                     
                     Question(question: "be ready to 〜", answers: ["〜に女性を紹介する", "〜の準備ができている", "〜に向かって進む", "〜をうれしく思う"], answer: 1),
                     
                     Question(question: "be sorry for 〜", answers: ["〜が原因で失敗する", "〜に反対する", "〜ということを気の毒に思う", "〜に驚く"], answer: 2),
                     
                     Question(question: "be proud of 〜", answers: ["〜を誇りに思う", "〜を外に出す", "〜の友だちになる", "の出身である"], answer: 0),
                     
                     Question(question: "be surprised at 〜", answers: ["〜に驚く", "〜で生まれる", "〜でわくわくする", "〜で特別な存在になる"], answer: 0),
                     
                     Question(question: "be sick in bed", answers: ["ベッドの修理をする", "ベッドの掃除をする", "病院に行く", "病気で寝ている"], answer: 3),
                     
                     Question(question: "because of 〜", answers: ["〜のお陰で", "〜が原因で", "〜に驚いて", "〜の前に"], answer: 1),
                     
                     Question(question: "between 〜 and …", answers: ["〜と…の両方", "〜と…の間に", "〜と…以外に", "〜と…と一緒に"], answer: 1),
                     
                     Question(question: "both 〜 and …", answers: ["〜と…の間に", "〜と…以外に", "〜と…と一緒に", "〜と…の両方"], answer: 3),
                     
                     Question(question: "by the way", answers: ["道沿いに", "ついに", "その道を通って", "ところで"], answer: 3),
                     
                     Question(question: "come back", answers: ["生き返る", "後ろに進む", "戻ってくる", "反対する"], answer: 2),
                     
                     Question(question: "come from 〜", answers: ["〜出身である", "〜から帰る", "〜から見える", "〜に向かっていく"], answer: 0),
                     
                     Question(question: "come in 〜", answers: ["〜に入ってくる", "〜で過ごす", "〜に帰る", "〜に行く"], answer: 0),
                     
                     Question(question: "come true", answers: ["必ず来る", "実現する", "嘘をつく", "正直に言う"], answer: 1),
                     
                     Question(question: "do one's best'", answers: ["行儀を良くする", "いつも通りにする", "最善を尽くす", "今度こそ行う"], answer: 2),
                     
                     Question(question: "decide to 〜", answers: ["〜したいと思う", "〜を諦める", "〜をはっきりと言う", "〜しようと決心する"], answer: 3),
                     
                     Question(question: "each other", answers: ["必ず", "お互いに", "いつか", "独自に"], answer: 1),
                     
                     Question(question: "enjoy 〜ing", answers: ["〜することを決断する", "〜と仲良くやっていく", "〜することを楽しむ", "〜から外に出る"], answer: 3),
                     
                     Question(question: "for example", answers: ["初めて", "実際は", "例えば", "目的は"], answer: 2),
                     
                     Question(question: "for the first time", answers: ["初めて", "1度に", "早い時間に", "今度"], answer: 0),
                     
                     Question(question: "from 〜　to ･･･", answers: ["〜から･･･まで", "〜の代わりに･･･する", "〜と･･･は異なる", "〜と･･･を見分ける"], answer: 0),
                     
                     Question(question: "from now on", answers: ["まさに今", "今後", "以前", "大昔"], answer: 1),
                     
                     Question(question: "get along with 〜", answers: ["〜を得る", "〜と一緒に行く", "〜を持っていく", "〜と仲良くやっていく"], answer: 4),
                     
                     Question(question: "get angry", answers: ["正直に言う", "幸せになる", "貴重品を得る", "怒る"], answer: 3),
                     
                     Question(question: "get home", answers: ["帰宅する", "家を買う", "家出する", "家を建てる"], answer: 0),
                     
                     Question(question: "get well", answers: ["井戸を掘る", "上手に行う", "よく寝る", "良くなる"], answer: 3),
                     
                     Question(question: "get out of 〜", answers: ["〜から物を得る", "〜から外に出る", "〜の外側を見る", "〜の周りを回る"], answer: 1),
                     
                     Question(question: "get back", answers: ["後ずさりする", "背後に回る", "戻る", "肩こりがする"], answer: 2),
                     
                     Question(question: "get dark", answers: ["暗い気持ちになる", "濃い目の色を塗る", "暗くなる", "悪いことをする"], answer: 2),
                     
                     Question(question: "get off 〜", answers: ["〜を降りる", "〜を安く買う", "〜をはずす", "〜を外に出す"], answer: 0),
                     
                     Question(question: "get on 〜", answers: ["〜に着く", "〜で過ごす", "〜に乗る", "〜に賛成する"], answer: 2),
                     
                     Question(question: "get to 〜", answers: ["〜に買い物に行く", "〜することが得意である", "〜するために努力する", "〜に着く"], answer: 3),
                     
                     Question(question: "get up", answers: ["見方になる","持ち上げる", "起きる", "運ぶ"], answer: 2),
                     
                     Question(question: "give up", answers: ["諦める", "手伝う", "達成する", "回復する"], answer: 0),
                     
                     Question(question: "go to sleep", answers: ["宿泊施設に行く", "目を覚ます", "仕事を休む", "眠る"], answer: 3),
                     
                     Question(question: "go for a walk", answers: ["ダイエットをする", "ゆっくり進む", "靴を買いに行く", "散歩に出かける"], answer: 3),
                     
                     Question(question: "go 〜ing", answers: ["〜するつもりである", "〜して楽しく過ごす", "〜をしに行く", "〜しながら進む"], answer: 2),
                     
                     Question(question: "have been to 〜", answers: ["〜している状態である", "〜させられた状態である", "〜すべきである", "〜に行ったことがある"], answer: 3),
                     
                     Question(question: "have to 〜", answers: ["〜しなければならない", "〜することができる", "〜を持っていく", "〜を食べたことがある"], answer: 0),
                     
                     Question(question: "have a good time", answers: ["楽しく過ごす", "時間に正確である", "予定通りに行う", "良い時計を持っている"], answer: 0),
                     
                     Question(question: "hear from 〜", answers: ["〜出身かを聞く", "〜から便りがある", "〜から声が聞こえる", "〜のニュースを聞く"], answer: 1),
                     
                     Question(question: "hear of 〜", answers: ["〜が聞こえるかどうか確認する", "〜のことを聞く", "〜のお陰である", "〜に注意する"], answer: 1),
                     
                     Question(question: "How often 〜?", answers: ["どのくらいの距離ですか？", "〜はいくらですか？", "〜はどうですか？", "どのくらいの頻度ですか？"], answer: 3),
                     
                     Question(question: "How far 〜", answers: ["どのくらいの頻度ですか？", "どのくらいの距離ですか？", "いくらですか？", "何回ですか？"], answer: 1),
                     
                     Question(question: "How much 〜?", answers: ["何回ですか？", "いくらですか？", "何歳ですか？", "どのくらいの長さですか？"], answer: 1),
                     
                     Question(question: "How many 〜?", answers: ["いくらですか？", "何歳ですか？", "どのくらい多くの？", "〜はどうですか？"], answer: 2),
                     
                     Question(question: "How many times 〜?", answers: ["何回ですか？", "何時ですか？", "どのくらいの長さですか？", "〜はどうですか？"], answer: 0),
                     
                     Question(question: "in fact", answers: ["正直に言うと", "原因は", "実は", "もちろん"], answer: 2),
                     
                     Question(question: "in front of 〜", answers: ["〜の理由は", "〜の前で", "〜の真実は", "〜の受付で"], answer: 1),
                     
                     Question(question: "in the future", answers: ["結果", "将来", "時間通りに", "実は"], answer: 1),
                     
                     Question(question: "instead of 〜", answers: ["〜の前に", "〜に反対する", "〜の代わりに", "〜の原因は"], answer: 2),
                     
                     Question(question: "look after 〜", answers: ["〜の世話をする", "〜の後ろを見る", "〜の将来を考える", "〜を卒業する"], answer: 0),
                     
                     Question(question: "look for 〜", answers: ["〜を探す", "〜の方向を見る", "〜の世話をする", "〜を予言する"], answer: 0),
                     
                     Question(question: "look forward to 〜", answers: ["〜の方向を見る", "〜を前もって準備する", "〜を探す", "〜を楽しみに待つ"], answer: 3),
                     
                     Question(question: "look like 〜", answers: ["好みの〜を見る", "〜のように見える", "〜の世話をする", "〜を探す"], answer: 1),
                     
                     Question(question: "May I 〜?", answers: ["〜しませんか？", "〜してもいいですか？", "〜するつもりですか？", "〜しなければいけませんか？"], answer: 1),
                     
                     Question(question: "more than 〜", answers: ["〜より少ない", "〜の代わりに", "〜のほとんど", "〜より多い"], answer: 3),
                     
                     Question(question: "most of 〜", answers: ["〜の人々", "〜の1人", "〜のとなりに", "〜のほとんど"], answer: 3),
                     
                     Question(question: "next to 〜", answers: ["次回〜する", "将来〜するために", "〜のとなりに", "〜に進む"], answer: 2),
                     
                     Question(question: "not as 〜 as ･･･", answers: ["･･･ほど〜でない", "･･･すると〜しない", "〜と同じくらい･･･", "〜をすればするほど･･･"], answer: 0),
                     
                     Question(question: "one day", answers: ["ある日", "（ある）1日", "1日（ついたち）", "いつか"], answer: 0),
                     
                     Question(question: "one of 〜", answers: ["〜の初日", "〜の1番目に", "〜の1つ", "〜のある日"], answer: 2),
                     
                     Question(question: "of course", answers: ["もちろん", "ゴルフコースの", "コース料理の", "行き先の"], answer: 0),
                     
                     Question(question: "on time", answers: ["時計で", "タイムを取る", "時間通りに", "未来に"], answer: 2),
                     
                     Question(question: "on foot", answers: ["足でける", "歩いて", "靴をはく", "裸足で"], answer: 1),
                     
                     Question(question: "over there", answers: ["たくさんある", "向こうに", "彼ら以上に", "飛び越えて"], answer: 1),
                     
                     Question(question: "part of 〜", answers: ["〜の前に", "〜の代わりに", "〜の1部分", "〜の原因は"], answer: 2),
                     
                     Question(question: "put on 〜", answers: ["〜を着る", "〜のスイッチを入れる", "〜に重ねる", "〜を持つ"], answer: 0),
                     
                     Question(question: "right now", answers: ["今すぐ", "右側に", "権利がある", "これからずっと"], answer: 0),
                     
                     Question(question: "run away", answers: ["早く走る", "会社を経営する", "盗塁する", "逃げる"], answer: 3),
                     
                     Question(question: "Shall we 〜 ?", answers: ["〜するつもりですか？", "〜しませんか？", "〜しなければいけませんか？", "〜はどうですか？"], answer: 1),
                     
                     Question(question: "Shall I 〜?", answers: ["〜するつもりですか？？", "〜しましょうか？", "〜するつもりですか？", "〜しなければいけませんか？"], answer: 1),
                     
                     Question(question: "sit down", answers: ["下山する", "下を向く", "転ぶ", "座る"], answer: 3),
                     
                     Question(question: "some day", answers: ["何日間か", "ある日", "以前", "いつか"], answer: 3),
                     
                     Question(question: "such as 〜", answers: ["そんな〜は", "とても〜", "〜のような", "〜に向かって"], answer: 2),
                     
                     Question(question: "take 〜 out", answers: ["〜を連れて行く", "〜を持ち帰る", "〜の写真を撮る", "〜以上の時間がかかる"], answer: 0),
                     
                     Question(question: "take care of 〜", answers: ["〜の面倒を見る", "〜を注意深く見る", "〜に気をつける", "〜の写真を撮る"], answer: 0),
                     
                     Question(question: "take a walk", answers: ["歩きスマホをする", "散歩する", "歩くと時間がかかる", "持ち帰る"], answer: 1),
                     
                     Question(question: "take 〜 to･･･", answers: ["〜を･･･に持ち帰る", "〜の写真を取るために･･･に行く？", "〜へ時間をかけて･･･に行く", "〜を･･･に連れて行く"], answer: 3),
                     
                     Question(question: "take part in 〜", answers: ["〜で撮影する", "〜に参加する", "〜の部品を持っている", "〜を持ち帰る"], answer: 1),
                     
                     Question(question: "these days", answers: ["これらの日に", "最近は", "たくさんの日に", "彼らの日に"], answer: 1),
                     
                     Question(question: "think of 〜", answers: ["〜を思い出す", "〜のおかげで", "〜を思いつく", "〜の面倒を見る"], answer: 2),
                     
                     Question(question: "thanks to 〜", answers: ["〜のおかげで", "〜に感謝する", "〜にお礼をいう", "〜を思いつく"], answer: 0),
                     
                     Question(question: "the other day", answers: ["別の日に", "将来", "先日", "ある日"], answer: 2),
                     
                     Question(question: "too 〜 to ･･･", answers: ["･･･するために〜をする", "･･･するには〜過ぎる", "･･･するために〜に行く", "･･･するやいなや〜する"], answer: 1),
                     
                     Question(question: "wait for 〜", answers: ["〜を重くする", "〜を待つ", "〜に行く", "〜を持っていく"], answer: 1),]


    }
        
        
func Hide(){
    LabelEnd.isHidden = true
    Next.isHidden = true
}
    func UnHide(){
LabelEnd.isHidden = false
Next.isHidden = false
}


//        let HighscoreDefault = UserDefaults.standard
//        if HighscoreDefault.value(forKey: "Highscore") != nil {
//            
//            Highscore.text = NSString(format: "Highscore: %i", highScore) as String
//        }
//        RandomQuestion()
//        createSounds()
//    }

//    func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
//    func RandomQuestion(){
//        if Questions.count > 0{
//            //questionNumber = arc4random() Questions.count
//            Label.text = Questions[questionNumber].question
//            answerNumber = Questions[questionNumber].answer
//            
//            for i in 0..<buttons.count{
//                buttons[i].setTitle(Questions[questionNumber].answers[i], for: UIControlState())
//            }
//            Score.text = NSString(format: "Score: %i", scoreNum) as String
//            Highscore.text = NSString(format: "Highscore: %i", highScore) as String
//
//            if scoreNum > highScore{
//                highScore = scoreNum
//                Highscore.text = NSString(format: "Highscore: %i", highScore) as String
//                
//                let HighscoreDefault = UserDefaults.standard
//                HighscoreDefault.setValue(highScore, forKey: "Highscore")
//                HighscoreDefault.synchronize()
//            }
            //This will remove the question from the array but due to the small number I feel better that they can repeat
 //           Questions.remove(at: questionNumber)
//        }
//        
//        else {
//                NSLog("done")
//        }
//    }
    
    
    @IBAction func button1(_ sender: AnyObject) {
        if answerNumber == 0 {
            scoreNum += 1
            AudioServicesPlaySystemSound(CorrectSound)
            //RandomQuestion()
        }
        
        else {
            scoreNum = 0
            AudioServicesPlaySystemSound(WrongSound)
            //RandomQuestion()
        }
        
    }

    @IBAction func button2(_ sender: AnyObject) {
        if answerNumber == 1 {
            scoreNum += 1
            AudioServicesPlaySystemSound(CorrectSound)
            //RandomQuestion()
        }
            
        else {
            scoreNum = 0
            AudioServicesPlaySystemSound(WrongSound)
            //RandomQuestion()
        }

        
    }
    
    @IBAction func button3(_ sender: AnyObject) {
        if answerNumber == 2 {
            scoreNum += 1
            AudioServicesPlaySystemSound(CorrectSound)
            //RandomQuestion()
        }
            
        else {
            scoreNum = 0
                AudioServicesPlaySystemSound(WrongSound)
            //RandomQuestion()
        }

    }
    
    @IBAction func button4(_ sender: AnyObject) {
        if answerNumber == 3 {
            scoreNum += 1
            AudioServicesPlaySystemSound(CorrectSound)
            //RandomQuestion()
        }
            
        else {
            scoreNum = 0
            AudioServicesPlaySystemSound(WrongSound)
            //RandomQuestion()
}
    }
}
