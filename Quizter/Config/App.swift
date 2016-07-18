//
//  App.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/13/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

public struct CellIdentifiers {
    static let DefaultCellId: String = "DefaultCellId"
    static let AnswerCellId: String = "AnswerCellId"
    static let QuestionCellId: String = "QuestionCellId"
    static let GameModeCellID: String = "GameModeCellID"
}

public let DefaultBinaryCellCount: Int = 3
public let DefaultMultipliCellCount: Int = 2
public let NumberOfGuessesInMultipliMode: Int = 3



/// **** DataSource ****
class DataSource {
    
    /**
     Get application dummy data
     
     - returns: [Author]
     */
    class func get() -> [Author] {
        return
            [Author(name: "Oscar Wild", quotes:
                [Quote(text: "Be yourself; everyone else is already taken"),
                    Quote(text: "Always forgive your enemies; nothing annoys them so much."),
                    Quote(text: "We are all in the gutter, but some of us are looking at the stars.")]),
             Author(name: "George Orwell", quotes:
                [Quote(text: "So much of left-wing thought is a kind of playing with fire by people who don't even know that fire is hot."),
                    Quote(text: "War is peace. Freedom is slavery. Ignorance is strength."),
                    Quote(text: "Freedom is the right to tell people what they do not want to hear.")]),
             Author(name: "Ernest Hemingway", quotes:
                [Quote(text: "The best way to find out if you can trust somebody is to trust them."),
                    Quote(text: "Never go on trips with anyone you do not love."),
                    Quote(text: "I love sleep. My life has the tendency to fall apart when I'm awake, you know?")]),
             Author(name: "Stephen King", quotes:
                [Quote(text: "The trust of the innocent is the liar's most useful tool."),
                    Quote(text: "Talent is cheaper than table salt. What separates the talented individual from the successful one is a lot of hard work."),
                    Quote(text : "I love crime, I love mysteries, and I love ghosts.")]),
             Author(name: "Martin Luther King, Jr.", quotes:
                [Quote(text: "I have decided to stick with love. Hate is too great a burden to bear."),
                    Quote(text: "Life's most persistent and urgent question is, 'What are you doing for others?'"),
                    Quote(text: "In the End, we will remember not the words of our enemies, but the silence of our friends.")]),
             Author(name: "Mark Twain", quotes:
                [Quote(text: "The secret of getting ahead is getting started."),
                    Quote(text: "You can't depend on your eyes when your imagination is out of focus."),
                    Quote(text: "Go to Heaven for the climate, Hell for the company.")]),
             Author(name: "Ray Bradbury, WD", quotes:
                [Quote(text: "I don’t need an alarm clock. My ideas wake me."),
                    Quote(text: "Just write every day of your life. Read intensely. Then see what happens. Most of my friends who are put on that diet have very pleasant careers."),
                    Quote(text: "Let the world burn through you. Throw the prism light, white hot, on paper.")]),
             Author(name: "Winston Churchill", quotes:
                [Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts."),
                    Quote(text: "Success consists of going from failure to failure without loss of enthusiasm."),
                    Quote(text: "You have enemies? Good. That means you've stood up for something, sometime in your life.")]),
             Author(name: "Nelson Mandela", quotes:
                [Quote(text: "It always seems impossible until its done."),
                    Quote(text: "Education is the most powerful weapon which you can use to change the world."),
                    Quote(text: "After climbing a great hill, one only finds that there are many more hills to climb.")]),
             Author(name: "Walt Disney", quotes:
                [Quote(text: "The way to get started is to quit talking and begin doing."),
                    Quote(text: "If you can dream it, you can do it."),
                    Quote(text: "All our dreams can come true, if we have the courage to pursue them.")])]
    }
    
}

// MARK: - APPLICATION DATASOURCE
//let APPLICATION_DATASOURCE: [Author] = [
    