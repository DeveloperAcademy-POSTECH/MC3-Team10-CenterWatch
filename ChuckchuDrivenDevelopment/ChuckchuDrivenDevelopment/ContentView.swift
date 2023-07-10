//
//  ContentView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI


struct ContentView: View {

    @EnvironmentObject var sampleViewModel: SampleViewModel
    
    var body: some View {
        VStack {
            ForEach(sampleViewModel.samples, id:\.self) { sample in
                HStack {
                    Text(sample.name)
                        .font(.system(size: 20))
                    Text(sample.text)
                }
            }
        }
        .task {
            await sampleViewModel.fetchSamples()
        }
    }


}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SampleViewModel())
    }
}
