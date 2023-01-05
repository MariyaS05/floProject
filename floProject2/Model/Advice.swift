//
//  Advices.swift
//  floProject2
//
//  Created by Мария  on 10.11.22.
//

import Foundation

struct MSectionAdvices : Hashable {
    let type : AdvicesType
    let items : [Advice]
}

enum AdvicesType: Hashable,CaseIterable {
    case buttons
    case menstrualCycle
    case basicOfFood
    case beautySecrets
    case cycleWorkaut
    case healthySleep
    case healthyWeight
    case harmony
    case reproductiveHealth
}

struct Advice : Hashable {
    let imageName : String
    let title : String
}
struct DetailAdvices : Hashable {
    let title : String
    let imageOfDetailAdvice : String
}
struct DescriptionOfAdvice {
    let description : String
}

class AllAdvices {
    var advicesMenstrualCycle = [Advice]()
    var advicesHealthyWeight = [Advice]()
    var advicesReproductiveHealth = [Advice]()
    var advicesHealthySleep = [Advice]()
    var advicesHarmony = [Advice]()
    var advicesBeautySecrets = [Advice]()
    var advicesCycleWorkaut = [Advice]()
    var advicesBasicOfFood = [Advice]()
    var sections  = [MSectionAdvices]()
    var buttons = [Advice]()
    
   

    init() {
       setup()
    }
    func setup(){

        let mestrualCycle = [Advice(imageName: "1", title: "Популярные вопросы о месячных"),
                             Advice(imageName: "2", title: "Как устроен ваш цикл"),
                             Advice(imageName: "3", title: "Нерегулярный цикл:в чем причина"),
                             Advice(imageName: "4", title: "Месячные без боли"),
                             Advice(imageName: "5", title: "Все об овуляции")]
        self.advicesMenstrualCycle =  mestrualCycle
        
        let healthyWeight = [Advice(imageName: "HealthyWeight1", title: "Основы питания для женского здоровья"),
                             Advice(imageName: "HealthyWeight2", title: "Как поддерживать водный баланс"),
                             Advice(imageName: "HealthyWeight3", title: "Питание при тренировках"),
                             Advice(imageName: "HealthyWeight4", title: "Как контролировать вес")]
        
        self.advicesHealthyWeight = healthyWeight
      
        let reproductiveHealth = [Advice(imageName: "ReproductiveHealth1", title: "Визит к гинекологу:подготовка"),
                                  Advice(imageName: "ReproductiveHealth2", title: "Хочу стать мамой"),
                                  Advice(imageName: "ReproductiveHealth3", title: "Все о цистите"),
                                  Advice(imageName: "ReproductiveHealth4", title: "Женская гигиена")]
        
        self.advicesReproductiveHealth = reproductiveHealth
        
        let healthySleep = [Advice(imageName: "HealthySleep1", title: "Хороший сон-крепкий организм"),
                            Advice(imageName: "HealthySleep2", title: "Как улучшить свой сон"),
                            Advice(imageName: "HealthySleep3", title: "Устанавливаем режим сна"),
                            Advice(imageName: "HealthySleep4", title: "Медитативные истории на ночь")]

        self.advicesHealthySleep = healthySleep
        
        let harmony = [Advice(imageName: "Harmony1", title: "Мыслите позитивно"),
                       Advice(imageName: "Harmony2", title: "Женское здоровье и стресс"),
                       Advice(imageName: "Harmony3", title: "Привычки ЗОЖ"),
                       Advice(imageName: "Harmony4", title: "Как взять стресс под контроль"),
                       Advice(imageName: "Harmony5", title: "Ваш марафон здоровья")]
      
        self.advicesHarmony = harmony
        let beautySecrets = [Advice(imageName: "beautySecrets1", title: "Кожа без прыщей"),
                             Advice(imageName: "beautySecrets2", title: "Акне можно побороть"),
                             Advice(imageName: "beautySecrets3", title: "Уход за телом и волосами"),
                             Advice(imageName: "beautySecrets4", title: "Почему появляется акне"),
                             Advice(imageName: "beautySecrets5", title: "Ваш путь к идеальной коже")]
        
        self.advicesBeautySecrets = beautySecrets
        let cycleWorkaut = [Advice(imageName: "CycleWorkaut1", title: "Что нужно делать после тренировки"),
                            Advice(imageName: "CycleWorkaut2", title: "Факты и мифы о фитнесе"),
                            Advice(imageName: "CycleWorkaut3", title: "Домашние тренировки"),
                            Advice(imageName: "CycleWorkaut4", title: "Чередование нагрузки"),
                            Advice(imageName: "CycleWorkaut5", title: "Создаем программу тренировок")]
    
        self.advicesCycleWorkaut = cycleWorkaut
        let basicOfFood = [Advice(imageName: "basicFood1", title: "Женское здоровье и питание"),
                           Advice(imageName: "basicFood2", title: "Метаболизм: пища для энергии"),
                           Advice(imageName: "basicFood3", title: "Советы для полезного рациона"),
                           Advice(imageName: "basicFood4", title: "Рацион для вегетарианцев"),
                           Advice(imageName: "basicFood5", title: "Вся ли еда полезна?")]
     
        
        self.advicesBasicOfFood = basicOfFood
//
        buttons = [.init(imageName: "nil", title: "Все советы"),.init(imageName: "nil", title: "Сохраненное")]
        
        sections = [.init(type: .buttons, items: buttons),.init(type: .menstrualCycle, items: mestrualCycle),.init(type: .basicOfFood, items: basicOfFood),.init(type: .beautySecrets, items: beautySecrets),.init(type: .cycleWorkaut, items: cycleWorkaut),.init(type: .harmony, items: harmony),.init(type: .healthySleep, items: healthySleep),.init(type: .healthyWeight, items: healthyWeight),.init(type: .reproductiveHealth, items: reproductiveHealth)]
    }
    
    
    
}


