//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.

struct Repositories: Codable {
    var items: [Repository]
}

struct Repository: Codable{
    var name: String?
    var description: String?
    var language: String?
    var starCount: Int?
    var watcherCount: Int?
    var forkCount: Int?
    var issueCount: Int?
    var owner: Owner?


    enum CodingKeys: String, CodingKey {
        case name
        case description
        case language
        case starCount = "stargazers_count"
        case watcherCount = "watchers_count"
        case forkCount = "forks_count"
        case issueCount = "open_issues_count"
        case owner
    }

    struct Owner: Codable {
        var username: String
        var avatarImageURL: String

        enum CodingKeys: String, CodingKey {
            case username = "login"
            case avatarImageURL = "avatar_url"
        }
    }

}
