//
//  CustomTabBarView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 18/05/25.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case list, calendar

    var icon: String {
        switch self {
        case .calendar:
            "calendar"
        case .list:
            "list.bullet"
        }
    }

    var title: String {
        return rawValue.capitalized
    }
}

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab
    @Binding var showingJournalForm: Bool
    @Namespace private var animationNamespace

    var body: some View {
        ZStack(alignment: .bottom) {
            // Floating Action Button
            HStack {
                Spacer()
                FloatingActionButton(action:  {
                    showingJournalForm = true
                }, icon: "square.and.pencil")
                .offset(y: -82)
            }

            // Tab Bar Items
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.spring) {
                            selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 20))
                            Text(tab.title)
                                .font(.caption)
                        }
                        .foregroundStyle(
                            selectedTab == tab ? Color.theme.accent : Color.theme.secondaryText
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background {
                            if selectedTab == tab {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.theme.background.opacity(0.2))
                                    .matchedGeometryEffect(id: "TAB", in: animationNamespace)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.regularMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
        }
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.calendar), showingJournalForm: .constant(false))
}
