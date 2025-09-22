# UBIKO Mobile

Una aplicación móvil desarrollada en Flutter que integra mapas interactivos con seguimiento de ubicación en tiempo real.

## 📱 Descripción

...

## ✨ Características Principales

- **🗺️ Mapa Interactivo**: Visualización de mapas interactivos utilizando Google Maps
- **📍 Ubicación en Tiempo Real**: Seguimiento y visualización de la ubicación actual del usuario
- **🔐 Gestión de Permisos**: Manejo elegante de permisos de ubicación
- **🎨 Interfaz Moderna**: Diseño atractivo con Material Design 3
- **🌙 Tema Claro/Oscuro**: Alternancia entre temas claro y oscuro
- **🧭 Controles de Mapa**: Botones para obtener ubicación y recentrar el mapa
- **📱 Navegación por Pestañas**: Interfaz con múltiples secciones (Mapa, Perfil, Configuración)

## 🏗️ Arquitectura

La aplicación utiliza una arquitectura basada en:

- **BLoC Pattern**: Para la gestión de estado robusta
- **Provider**: Para inyección de dependencias
- **Clean Architecture**: Separación clara de responsabilidades
- **Servicios**: Capa de servicios para operaciones de ubicación

## 📁 Estructura del Proyecto

```
lib/
├── core/
│   ├── config/          # Configuraciones de la app
│   ├── error/           # Manejo de errores
│   └── utils/           # Utilidades
├── features/
│   └── map/             # Funcionalidades del mapa
├── main.dart            # Punto de entrada de la aplicación
├── main_screen.dart     # Pantalla principal con navegación
├── map_page.dart        # Página del mapa
├── profile_page.dart    # Página de perfil
├── settings_page.dart   # Página de configuración
├── location_bloc.dart   # BLoC para gestión de ubicación
├── location_event.dart  # Eventos de ubicación
├── location_state.dart  # Estados de ubicación
└── location_service.dart # Servicio de ubicación
```

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Google Maps Flutter**: Integración de Google Maps
- **Flutter BLoC**: Gestión de estado
- **Geolocator**: Servicios de geolocalización
- **Permission Handler**: Gestión de permisos
- **Provider**: Inyección de dependencias
- **Google Fonts**: Tipografías personalizadas
- **Material Design 3**: Sistema de diseño moderno

## 📋 Requisitos Previos

- Flutter SDK (>=3.2.3 <4.0.0)
- Dart SDK
- Android Studio / VS Code
- Dispositivo Android/iOS o emulador

## 🚀 Instalación

1. **Clonar el repositorio**
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   cd UBIKO_MOBILE
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**
   - Crear un archivo `.env` en la raíz del proyecto
   - Agregar las claves de API necesarias

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 🔧 Configuración

### API Keys
La aplicación requiere configurar las siguientes claves de API:

- **Google Maps API Key**: Para la funcionalidad de mapas
- Configurar en el archivo `.env`

### Permisos
La aplicación solicita los siguientes permisos:

- **Ubicación**: Para acceder a la ubicación del dispositivo
- **Ubicación en segundo plano**: Para seguimiento continuo (opcional)

## 📱 Uso

1. **Pantalla Principal**: Navegación entre las diferentes secciones
2. **Mapa**: Visualización del mapa con la ubicación actual
3. **Perfil**: Información del usuario
4. **Configuración**: Ajustes de la aplicación y tema

### Controles del Mapa
- **Botón de Ubicación**: Obtiene y muestra la ubicación actual
- **Recentrar**: Centra el mapa en la ubicación del usuario
- **Zoom**: Controles de acercamiento y alejamiento

## 🧪 Testing

Ejecutar las pruebas:

```bash
flutter test
```

## 📦 Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

5. Abrir un Pull Request

## 👥 Equipo

- **Desarrollo**: Equipo UBIKO

## 🔄 Roadmap

### Próximas Funcionalidades
- [ ] Actualizaciones de ubicación en tiempo real
- [ ] Marcadores personalizados
- [ ] Historial de ubicaciones

---

**UBIKO Mobile** - Conectando lugares 🌍
