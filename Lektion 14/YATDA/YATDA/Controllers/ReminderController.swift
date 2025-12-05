//
//  StateController.swift
//  YATDA
//
//  Created by dmu mac 29 on 30/10/2025.
//
import Foundation

@Observable
class ReminderController {
    var reminders: [Reminder] = []


    ///Dependency Inversion Princip fra SOLID
    @ObservationIgnored
    let storageService: StorageMethod
    @ObservationIgnored
    let storageListnerService: StorageListner?

    init(storageService: StorageMethod, storageListner: StorageListner) {
        self.storageService = storageService
        self.storageListnerService = storageListner
        storageListnerService?.subscribe { [weak self] (elements: [Reminder]) in
            self?.reminders = elements
        }
    }

    init(storageService: StorageMethod) {
        self.storageService = storageService
        self.storageListnerService = nil
    }

    deinit {
        if let storageListnerService {
            storageListnerService.unsubscribe()
        }
    }

    func addReminder(_ reminder: Reminder) {
        Task {
            do {
                try storageService.create(element: reminder)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func updateReminder(_ reminder: Reminder) {
        Task {
            do {
                try storageService.update(reminder)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func deleteReminder(_ reminder: Reminder) {
        Task {
            do {
                try await storageService.delete(reminder)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

}
