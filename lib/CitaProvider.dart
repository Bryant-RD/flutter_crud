import 'package:crud_cita/API/CitaService.dart';
import 'package:crud_cita/Entitys/Cita.dart';
import 'package:flutter/foundation.dart';

class CitaProvider extends ChangeNotifier {
  List<Cita> _citas = [];

  List<Cita> get citas => _citas;

  void initCitas(List<Cita> citas) {
    _citas = citas;
    notifyListeners();
  }

  void addCita(Cita cita) {
    _citas.add(cita);
    notifyListeners();
  }

  void removeCita(Cita cita) {
    _citas.remove(cita);
    notifyListeners();
  }

  // Add other methods to update the state of your citas as needed...
}
