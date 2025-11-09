# quiz_app

"""
lib/
├─ main.dart
├─ core/
│ ├─ error/ # exceptions & failures
│ └─ network/ # network info (optional)
├─ data/
│ ├─ models/ # DTOs / json serializable models
│ ├─ datasources/ # local and remote sources
│ └─ repositories/ # implementations of domain repositories
├─ domain/
│ ├─ entities/ # pure dart business models
│ ├─ repositories/ # abstract repository interfaces
│ └─ usecases/ # single-responsibility use-cases
├─ presentation/
│ ├─ pages/ # screens/widgets
│ ├─ viewmodels/ # Riverpod ChangeNotifiers/StateNotifiers or plain classes
│ └─ widgets/ # UI components
└─ providers.dart # Riverpod providers wiring
"""
