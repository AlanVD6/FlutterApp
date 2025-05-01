import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController conUser = TextEditingController();
  TextEditingController conPdw = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/fondo.jpg')
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Image.asset('assets/logo.png', width: 400)
            ),
            
            Positioned(
              bottom: 50, 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,  
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: 400,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: conUser,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text('Nombre de usuario'),
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: conPdw,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Contraseña',
                            border: OutlineInputBorder()
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                
                  InkWell(
                    onTap: () {
                      isLoading = true;
                      setState(() {});
                      
                      Future.delayed(Duration(seconds: 4)).then((value) {
                        Navigator.pushNamed(context, '/dash');
                      },);

                      /*Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> 
                      const DashboardScreen(),
                      );*/

                    },
                    child: Lottie.asset('assets/boton.json', width: 210),
                  ),
                ],
              ),
            ),
            
            Positioned(
              top: 250,
              child: isLoading 
                ? Lottie.asset('assets/loading.json', height: 150)
                : Container()
            )
          ],
        ),
      ),
    );
  }
}