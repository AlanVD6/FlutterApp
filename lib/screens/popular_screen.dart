import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';

class PopularScreen extends StatefulWidget{

  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen>{

  ApiPopular? apiPopular;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    //apiPopular!.getPopularMovies();
  }

  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder(
        future: apiPopular!.getPopularMovies(),
        builder: (context, snapshot) {

          if (snapshot.hasData){

            return ListView.separated(

              padding: EdgeInsets.symmetric(horizontal: 10),
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                
                return ItemPopular(snapshot.data![index]);
              },
            );
            
          } else {

            if (snapshot.hasError) {

              return Center(child: Text(snapshot.error.toString()),);
            } else {

              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
      ),
    );
  }

  //generacion de un widget a través de un método
  Widget ItemPopular(PopularModel popular){

    return ClipRRect(

      borderRadius: BorderRadius.circular(10),
      
      child: Stack(

        alignment: Alignment.bottomLeft,
        children: [
          FadeInImage(
            
            placeholder: AssetImage('assets/PVtR.gif'), 
            image: NetworkImage(popular.backdropPath),
          ),

          Container(

            //width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.black,
            child: ListTile(

              onTap: () => Navigator.pushNamed(context, '/detail', arguments: popular),
              title: Text(popular.title, style: TextStyle(color: Colors.white),),
              trailing: Icon(Icons.chevron_right, size: 50),
            )
          )
        ],
      ),
    );
  }
}