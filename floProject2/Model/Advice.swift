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
    case menstrualCycle
    case basicOfFood
    case beautySecrets
    case cycleWorkaut
    case healthySleep
    case healthyWeight
    case harmony
    case reproductiveHealth
}

struct Advice : Hashable, Codable {
    let imageName : String
    let title : String
    let description : DescriptionOfAdvice?
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
    
    init() {
       setup()
    }
    func setup(){
        let mestrualCycle = [Advice(imageName: "1", title: "Популярные вопросы о месячных",description: .questionsAboutPeriod),
                             Advice(imageName: "2", title: "Как устроен ваш цикл", description: .cycleOrganisation),
                             Advice(imageName: "3", title: "Нерегулярный цикл:в чем причина", description: .unregularMenstrualCycle),
                             Advice(imageName: "4", title: "Месячные без боли", description: .menstruationWithoutPain),
                             Advice(imageName: "5", title: "Все об овуляции", description: .aboutOvulation)]
        self.advicesMenstrualCycle =  mestrualCycle
        
        let healthyWeight = [Advice(imageName: "HealthyWeight1", title: "Основы питания для женского здоровья", description: .theBasicsOfWomenNutrition),
                             Advice(imageName: "HealthyWeight2", title: "Как поддерживать водный баланс", description: .waterBalance),
                             Advice(imageName: "HealthyWeight3", title: "Питание при тренировках", description: .nutritionDuringTraining),
                             Advice(imageName: "HealthyWeight4", title: "Как контролировать вес", description: .howToControlWeight)]
        
        self.advicesHealthyWeight = healthyWeight
      
        let reproductiveHealth = [Advice(imageName: "ReproductiveHealth1", title: "Визит к гинекологу:подготовка", description: .visitToTheGynecologist),
                                  Advice(imageName: "ReproductiveHealth2", title: "Хочу стать мамой", description: .beMother),
                                  Advice(imageName: "ReproductiveHealth3", title: "Все о цистите", description: .allAboutCystitis)]
        
        self.advicesReproductiveHealth = reproductiveHealth
        
        let healthySleep = [Advice(imageName: "HealthySleep1", title: "Хороший сон-крепкий организм", description: .goodDream),
                            Advice(imageName: "HealthySleep2", title: "Как улучшить свой сон", description: .howToImproveYourSleep),
                            Advice(imageName: "HealthySleep3", title: "Устанавливаем режим сна", description: .setSleepMode),
                            Advice(imageName: "HealthySleep4", title: "Медитативные истории на ночь", description: .meditationStories)]

        self.advicesHealthySleep = healthySleep
        
        let harmony = [Advice(imageName: "Harmony1", title: "Мыслите позитивно", description: .bePositive),
                       Advice(imageName: "Harmony2", title: "Женское здоровье и стресс", description: .womensHealthAndStress),
                       Advice(imageName: "Harmony3", title: "Привычки ЗОЖ", description: .healthyHabits),
                       Advice(imageName: "Harmony4", title: "Как взять стресс под контроль", description: .controlStress),
                       Advice(imageName: "Harmony5", title: "Ваш марафон здоровья", description: .healthMarathon)]
      
        self.advicesHarmony = harmony
        let beautySecrets = [Advice(imageName: "beautySecrets1", title: "Кожа без прыщей", description: .skinWithoutAcne),
                             Advice(imageName: "beautySecrets2", title: "Акне можно побороть", description: .acneCanBeOvercome),
                             Advice(imageName: "beautySecrets3", title: "Уход за телом и волосами", description: .bodyCare),
                             Advice(imageName: "beautySecrets4", title: "Почему появляется акне", description: .reasonsOfAcne),
                             Advice(imageName: "beautySecrets5", title: "Ваш путь к идеальной коже", description: .theWayToPerfectSkin)]
        
        self.advicesBeautySecrets = beautySecrets
        let cycleWorkaut = [Advice(imageName: "CycleWorkaut1", title: "Что нужно делать после тренировки", description: .afterTrainings),
                            Advice(imageName: "CycleWorkaut2", title: "Факты и мифы о фитнесе", description: .factsAboutFitness),
                            Advice(imageName: "CycleWorkaut3", title: "Домашние тренировки", description: .homeTrainings),
                            Advice(imageName: "CycleWorkaut4", title: "Чередование нагрузки", description: .alternationTrainings),
                            Advice(imageName: "CycleWorkaut5", title: "Создаем программу тренировок", description: .createTrainingsProgramm)]
    
        self.advicesCycleWorkaut = cycleWorkaut
        let basicOfFood = [Advice(imageName: "basicFood1", title: "Женское здоровье и питание", description: .healthyFood),
                           Advice(imageName: "basicFood2", title: "Метаболизм: пища для энергии", description: .methabolism),
                           Advice(imageName: "basicFood3", title: "Советы для полезного рациона", description: .advicesForRation),
                           Advice(imageName: "basicFood4", title: "Рацион для вегетарианцев", description: .rationForVegan),
                           Advice(imageName: "basicFood5", title: "Вся ли еда полезна?", description: .isAllTheFoodHealthy)]
     
        self.advicesBasicOfFood = basicOfFood

        sections = [.init(type: .menstrualCycle, items: mestrualCycle),.init(type: .basicOfFood, items: basicOfFood),.init(type: .beautySecrets, items: beautySecrets),.init(type: .cycleWorkaut, items: cycleWorkaut),.init(type: .harmony, items: harmony),.init(type: .healthySleep, items: healthySleep),.init(type: .healthyWeight, items: healthyWeight),.init(type: .reproductiveHealth, items: reproductiveHealth)]
    }
}


