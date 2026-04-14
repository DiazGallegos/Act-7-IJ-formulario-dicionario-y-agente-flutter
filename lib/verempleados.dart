import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatelessWidget {
  const VerEmpleados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la lista de empleados actuales en el diccionario
    final empleados = datosEmpleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: empleados.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 100, color: Colors.indigo.shade200),
                    const SizedBox(height: 20),
                    Text(
                      'No hay empleados registrados',
                      style: TextStyle(fontSize: 20, color: Colors.indigo.shade700, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Vuelve atrás e intenta registrar uno.',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: empleados.length,
                itemBuilder: (context, index) {
                  final emp = empleados[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.indigo.shade100,
                        child: Text(
                          emp.id.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade700, fontSize: 18),
                        ),
                      ),
                      title: Text(
                        emp.nombre, 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.work, size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 5),
                                Text(emp.puesto, style: TextStyle(fontSize: 16, color: Colors.grey.shade800)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 16, color: Colors.green.shade600),
                                const SizedBox(width: 5),
                                Text(
                                  emp.salario.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green.shade700)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
