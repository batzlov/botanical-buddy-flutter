import 'package:flutter/material.dart';

import '../../models/plant.dart';
import '../../services/api_service.dart';
import 'details.dart';
import '../../constants/config.dart';

class Plants extends StatefulWidget {
  const Plants({ Key? key }) : super(key: key);

  @override
  _PlantsState createState() => _PlantsState();
}

class _PlantsState extends State<Plants> {
  ApiService api = ApiService();
  late List<Plant> plants = <Plant>[];

  @override
  void initState() {
    api.fetchPlants().then((fetchedPlants) {
      if(fetchedPlants.length > 0) {
        setState(() {
          plants = fetchedPlants.cast<Plant>();
        });
      }
    });

    super.initState();
  }

  plantItem(Plant plant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(
            plant: plant
          ))
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(
          bottom: 20
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0, 3)
            )
          ],
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.network(
                baseUrl+"/uploads/"+plant.imageRef,
                height: 70,
                width: 70,
                
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${plant.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    Text(
                      'Entry ${plant.type}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.7)
                      )
                    ),
                  ]
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(plants.isEmpty == false) {
      return Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: plants.length,
          itemBuilder: (BuildContext context, int index) {
            return plantItem(plants.elementAt(index));
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10)
        )
      );
    }

    return const Center(
      child: Text("Hallo")
    );
  }
}