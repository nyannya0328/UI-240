//
//  Home.swift
//  UI-240
//
//  Created by にゃんにゃん丸 on 2021/06/18.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var model = MapViewModel()
    @State var locationManger = CLLocationManager()
    
    var body: some View {
        ZStack{
            MapView()
                .ignoresSafeArea()
                .environmentObject(model)
            
            VStack{
                
                VStack{
                    
                    HStack{
                        
                        
                        TextField("Search Location", text: $model.searchTxt)
                        
                        Button(action: {
                            
                            withAnimation{
                                
                                model.searchQuery()
                            }
                            
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: -5, y: -5)
                    .cornerRadius(10)
                    
                    if !model.places.isEmpty && model.searchTxt != ""{
                        
                        ScrollView{
                            
                            VStack{
                                
                                
                                ForEach(model.places){place in
                                    
                                    
                                    Text(place.placemark.name ?? "")
                                        .font(.footnote.italic())
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .onTapGesture {
                                            model.selectPlace(place: place)
                                        }
                                    
                                    
                                    Divider()
                                        .frame(width: 300, height: 0.1)
                                        .background(Color.red)
                                    
                                }
                            
                            }
                            .padding(.top,5)
                            
                            
                        }
                        .background(Color.white)
                        .shadow(radius: 5)
                        
                        
                        
                    }
                    
                    
                }
                .padding()
                
                
                Spacer()
                
                
                VStack{
                    
                    Button(action: model.foucingRegion, label: {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            
                    })
                    
                    Button(action: model.updateMapType, label: {
                        
                        
                        Image(systemName: model.mapTipe == .standard ? "network" : "map")
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                       
                    })
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing,5)
                
                
            }
            
            
        }
        .onAppear(perform: {
        
            locationManger.delegate = model
            locationManger.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $model.showAlert, content: {
            Alert(title: Text("Permission Denied"), message: Text("Pleace Enable permisson App Settings"), dismissButton: .default(Text("Go to Settings"),action: {
                
                
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
//        .onChange(of: model.searchTxt, perform: { value in
//            let delay = 0.3
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//
//
//                if value == model.searchTxt{
//
//                    model.searchQuery()
//
//
//
//                }
//
//            }
//        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
