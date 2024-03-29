//
//  NewDataView.swift
//  TaskApp
//
//  Created by BKS-GGS on 27/09/21.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack {
            HStack {
                Text("\(homeData.updateItem == nil ? "Add New" : "Update") Task")
                    .font(.system(size: 65))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            TextEditor(text: $homeData.content)
                .padding()
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("When")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 10) {
                DateButton(title: "Today", homeData: homeData)
                DateButton(title: "Tomorrow", homeData: homeData)
                
                //Date Picker
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            Button {
                homeData.writeData(context: context)
            } label: {
                Label {
                    Text(homeData.updateItem == nil ? "Add Now" : "Update")
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                } icon: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(
                    LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
            }
            .padding()
            //disabling button when no data
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1.0)
        }
        .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
    }
}

