import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    return Scaffold(
      appBar: MyAppBar(title: fileProvider.fileName),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Ménu principal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.indigo,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 110 * 4,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildMenuItem(context, 'Mostrar variables', Icons.abc, () {
                    Navigator.pushNamed(context, 'mostrar_variables');
                  }),
                  _buildMenuItem(context, 'Mostrar reglas', Icons.rule, () {
                    Navigator.pushNamed(context, 'mostrar_reglas');
                  }),
                  // _buildMenuItem(context, 'Opción 3', Icons.accessibility),
                  // _buildMenuItem(context, 'Opción 4', Icons.account_balance),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      VoidCallback function) {
    return GestureDetector(
      onTap: function,
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.indigo,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final fileProvider = Provider.of<FileProvider>(context);
//     // final dataProvider = Provider.of<DataProvider>(context);

//     return Scaffold(
//       appBar: MyAppBar(
//         title: fileProvider.fileName,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, 'add_variable'),
//                 child: Text('Añadir Variable')),
//             ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, 'mostrar'),
//                 child: Text('Mostrar contenido')),
//             ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, 'mostrar'),
//                 child: Text('Mostrar contenido')),
//             ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, 'add_rule'),
//                 child: Text('Add rule')),
//                 ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, 'mostrar_variables'),
//                 child: Text('Mostrar variables')),
//           ],
//         ),
//       ),
//     );
//   }
// }
