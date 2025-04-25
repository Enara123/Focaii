//
//  FormatDate.swift
//  Focaii
//
//  Created by Siluni on 2025-04-21.
//
import SwiftUI

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}
