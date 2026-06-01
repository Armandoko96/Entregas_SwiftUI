import SwiftUI

struct ConfiguracionView: View {
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        Form {
            Section(header: Text("Filtros y Orden")) {
                Picker("Orden de elementos", selection: $settings.orderType) {
                    Text("Ascendente").tag(0)
                    Text("Descendente").tag(1)
                }
                
                Toggle("Mostrar solo con foto", isOn: $settings.showOnlyWithPhoto)
            }
            
            Section(header: Text("Límites")) {
                Stepper("Límite de ítems: \(settings.itemLimit)", value: $settings.itemLimit, in: 1...20)
            }
        }
        .navigationTitle("Configuración")
    }
}
