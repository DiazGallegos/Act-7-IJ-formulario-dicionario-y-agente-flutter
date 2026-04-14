class Empleado {
  final int id;
  final String nombre;
  final String puesto;
  final double salario;

  Empleado({
    required this.id,
    required this.nombre,
    required this.puesto,
    required this.salario,
  });

  @override
  String toString() {
    return 'ID: $id, Nombre: $nombre, Puesto: $puesto, Salario: \$${salario.toStringAsFixed(2)}';
  }
}
