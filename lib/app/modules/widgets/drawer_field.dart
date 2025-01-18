import 'package:flutter/material.dart';
import 'package:getx_supabase/app/data/provider/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerField extends StatelessWidget {
  const DrawerField({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Image.asset('assets/images/logostar.png')),
          const Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('About Us'),
            onTap: () => {},
          ),
          const Divider(),
          Spacer(),
          MaterialButton(
            color: Colors.red,
            onPressed: () {
              SupabaseProvider.instance.signOut();
            },
            child: Text('Logout'),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
