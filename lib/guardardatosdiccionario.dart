import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Agente para guardar datos en el diccionario
  static void guardarEmpleado(String nombre, String puesto, double salario) {
    // Crear la instancia del empleado con el id autonumérico
    Empleado nuevoEmpleado = Empleado(
      id: proximoId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardar en el diccionario
    datosEmpleado[proximoId] = nuevoEmpleado;
    
    // Incrementar el id para el próximo registro
    proximoId++;
  }
}
