import 'dart:io';

void main() async {
  print('\n======================================================');
  print('👾 Agente: Guardar Repositorio en GitHub');
  print('======================================================\n');

  // 1. Verificar si git está inicializado
  bool isGitInit = await checkGitInitialized();
  if (!isGitInit) {
    print('📂 Inicializando repositorio Git (git init)...');
    await runCmd('git', ['init']);
  }

  // 2. Pedir la URL del repositorio
  stdout.write('👉 Ingresa el link del repositorio de GitHub (.git): ');
  String? repoUrl = stdin.readLineSync();
  if (repoUrl == null || repoUrl.trim().isEmpty) {
    print('\n❌ Error: El link del repositorio es obligatorio. Operación cancelada.');
    return;
  }
  
  // Agregar o actualizar el origin (remote)
  await setupRemote(repoUrl.trim());

  // 3. Ramas: usar 'main' por default o preguntar
  stdout.write('👉 ¿A qué rama deseas subir los cambios? (Presiona Enter para usar "main"): ');
  String? ramaInput = stdin.readLineSync();
  String rama = (ramaInput == null || ramaInput.trim().isEmpty) ? 'main' : ramaInput.trim();

  print('\n🔄 Estableciendo rama (git branch -M $rama)...');
  await runCmd('git', ['branch', '-M', rama]);

  // 4. Agregar todos los cambios
  print('📦 Agregando archivos al control de versiones (git add .)...');
  await runCmd('git', ['add', '.']);

  // 5. Preguntar por el mensaje de commit
  stdout.write('\n👉 Ingresa el mensaje del commit (Presiona Enter para "Commit inicial"): ');
  String? commitMsgInput = stdin.readLineSync();
  String commitMsg = (commitMsgInput == null || commitMsgInput.trim().isEmpty) ? 'Commit inicial' : commitMsgInput.trim();

  print('💾 Creando commit...');
  await runCmd('git', ['commit', '-m', commitMsg]);

  // 6. Push de los cambios
  print('\n🚀 Subiendo cambios a GitHub en la rama "$rama" (git push -u origin $rama)...');
  var pushResult = await runCmd('git', ['push', '-u', 'origin', rama]);

  if (pushResult.exitCode == 0) {
    print('\n✅ ¡Éxito! El proyecto se ha guardado y subido correctamente a GitHub.');
  } else {
    print('\n⚠️ Ocurrió un problema al subir los cambios. Revisa el registro arriba para ver los detalles de Git (por ejemplo si la red o los permisos fallaron).');
  }
  print('======================================================\n');
}

/// Helper para verificar si la carpeta actual ya es un repositorio de git
Future<bool> checkGitInitialized() async {
  var result = await Process.run('git', ['rev-parse', '--is-inside-work-tree']);
  return result.exitCode == 0;
}

/// Helper para añadir o cambiar la URL remota del repositorio de Git
Future<void> setupRemote(String url) async {
  var checkRemote = await Process.run('git', ['remote', 'get-url', 'origin']);
  if (checkRemote.exitCode == 0) {
    // Si ya existe un 'origin', actualizamos la URL
    print('🔄 Ya existía un origin, actualizando su URL...');
    await runCmd('git', ['remote', 'set-url', 'origin', url]);
  } else {
    // Si no existe, lo agregamos normalmente
    print('🔗 Vinculando repositorio local con la URL remota...');
    await runCmd('git', ['remote', 'add', 'origin', url]);
  }
}

/// Helper para ejecutar comandos de Git e imprimir sus resultados
Future<ProcessResult> runCmd(String executable, List<String> arguments) async {
  var result = await Process.run(executable, arguments);
  if (result.stdout.toString().isNotEmpty) print(result.stdout.toString().trim());
  if (result.stderr.toString().isNotEmpty) print(result.stderr.toString().trim());
  return result;
}
