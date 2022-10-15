import UIKit

//클래스가 인스턴스로 되기 위해서는, 클래스의 프로퍼티가 모두 초기화 되어 있어야 한다.
//프로퍼티가 옵셔널일 경우, 컴파일 오류는 나지 않지만 런타임 오류는 발생할 수 있다.
//프로퍼티 초기화를 위해 빈 괄호를 사용하는 것이 아닌, 초기화 구문을 통해 인자값을 넣어서 프로퍼티를 초기화합니다.

class Monster {
    var clothes: String
    var speed: Int
    var power: Int
    var experience: Double

    //초기화 구문
    init(clothes: String, speed: Int, power: Int, experience: Double){
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.experience = experience
    }
    
    func attack() {
        print("몬스터 공격!!")
    }
    
    
}

//easyMonster = 인스턴스 [실체화된 내용]
var easyMonster = Monster(clothes: "Orange", speed: 1, power: 10, experience: 50.0)
easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.experience

var hardMonster = Monster(clothes: "Blue", speed: 10, power: 500, experience: 10000)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.experience

//클래스는 상속이 가능하다.
//Monster: 부모클래스 (SuperClass), BossMonster: 자식클래스(SubClass)
class BossMonster:Monster {
    
    var bossName = "감자칩"
    
    func bossUniqueAttack() {
        print("보스만의 강력한 공격!!")
    }
    
    //override 함수는 부모클래스의 함수를 불러오는데 사용한다.
    override func attack() {
        //부모클래스의 기능도 사용하면서 재정의 하고 싶다면, super.을 사용한다.
        super.attack()
        print("보스의 공격!!")
    }
    
}

var boss = BossMonster(clothes: "Black", speed: 100, power: 50000, experience: 2000000)
boss.clothes
boss.speed
boss.power
boss.experience
boss.bossName
boss.attack()
boss.bossUniqueAttack()



//클래스와 달리 구조체는 초기화 구문을 제공해준다. -> 맴버와이즈 초기화 구문
//구조체는 상속이 되지 않는다.
struct Monster2 {
    var clothes: String
    var speed: Int
    var power: Int
    var experience: Double

}

//easyMonster = 인스턴스 [실체화된 내용]
var easyMonster2 = Monster2(clothes: "Orange", speed: 1, power: 10, experience: 50.0)
easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.experience

var hardMonster2 = Monster2(clothes: "Blue", speed: 10, power: 500, experience: 10000)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.experience



//Value Type vs Reference Type

var nickname: String = "고래밥"
var subNickName = nickname

nickname = "꼬깔콘"

print(nickname)
print(subNickName)

class SuperBoss {
    var name: String
    var level: Int
    var power: Int
    
    init(name: String, level: Int, power: Int){
        self.name = name
        self.level = level
        self.power = power
    }
}

var hardStepBoss = SuperBoss(name: "쉬운보스", level: 1, power: 100)

var easyStepBoss = hardStepBoss

hardStepBoss.power = 50000
hardStepBoss.level = 100
hardStepBoss.name = "어려운 보스"

print(hardStepBoss.name, hardStepBoss.level, hardStepBoss.power)
print(easyStepBoss.name, easyStepBoss.level, easyStepBoss.power)


//class는 참조타입으로 원본의 값을 수정한다                                            
