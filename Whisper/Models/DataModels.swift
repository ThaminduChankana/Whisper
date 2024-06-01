//
//  DataModels.swift
//  Story Time
//
//  Created by Thamindu Gamage on 2024-06-01.
//

import Foundation

struct UserInput {
    var childName: String
    var age: Int
    var gender: Gender
    var storyCategory: StoryCategory
    var timeline: Timeline
    var mood: Mood
}

enum Gender: String, CaseIterable {
    case boy = "Boy"
    case girl = "Girl"
}

enum StoryCategory: String, CaseIterable {
    case fairyTales = "Fairy Tales"
    case realLifeStories = "Real Life Stories"
    case folktales = "Folktales"
    case adventure = "Adventure"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case mystery = "Mystery"
    case animalStories = "Animal Stories"
    case historicalFiction = "Historical Fiction"
    case humor = "Humor"
    case bedtimeStories = "Bedtime Stories"
    case educationalNonFiction = "Educational and Non-Fiction"
    case classicLiterature = "Classic Literature"
    case multiculturalStories = "Multicultural Stories"
}

enum Timeline: String, CaseIterable {
    case kingdom = "Kingdoms"
    case eighteenHundreds = "1800's"
    case nineteenHundreds = "1900's"
    case present = "Present"
    case future = "Future"
    case farFuture = "Far Future"
}

enum Mood: String, CaseIterable {
    case happy = "Happy"
    case excited = "Excited"
    case sad = "Sad"
    case angry = "Angry"
    case feared = "Feared"
    case curious = "Curious"
    case contented = "Contented"
    case frustrated = "Frustrated"
    case bored = "Bored"
}
