//
//  TemplatesView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftData
import SwiftUI

struct TemplatesView: View {
    @EnvironmentObject private var templateVM: TemplateViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedTab = 0
    @State private var showingCreateTemplate = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UserTemplatesView()
                .tabItem {
                    Label("My Templates", systemImage: "folder")
                }
                .tag(0)
            
            TemplateBrowserView()
                .tabItem {
                    Label("Browse", systemImage: "square.grid.2x2")
                }
                .tag(1)
        }
        .navigationTitle("Templates")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingCreateTemplate = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingCreateTemplate) {
            NavigationView {
                TemplateFormView(mode: .create)
            }
        }
    }
}

struct TemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TemplatesView()
                .environmentObject(TemplateViewModel.preview)
        }
    }
}
