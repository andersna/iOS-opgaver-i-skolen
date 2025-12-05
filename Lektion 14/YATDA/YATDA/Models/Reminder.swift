// Reminder.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.24.
// Copyright © 2025 ksd. All rights reserved.
//
// 


import Foundation
import FirebaseFirestore

struct Reminder: Identifiable, Codable, FireStoreEntity {
  @DocumentID var id: String?
  var title: String
  var isCompleted = false
  static let collectionName = "Reminders"
}

struct DemoUser: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let gender: String
}
