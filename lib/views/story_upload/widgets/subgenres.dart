import 'package:flutter/material.dart';

class Subgenres {

  Future<List<String>> showSubgenrePopup(BuildContext context, List<String> allSubgenres, List<String> previouslySelected) async {
    List<String> temporary = List.from(previouslySelected);
    List<String> filtered = List.from(allSubgenres);

    return await showDialog(
      context: context,
      builder: (_){
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Add subgenres"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search"
                      ),
                      onChanged: (query) {
                        setState((){
                          filtered = allSubgenres.where((genre) => genre.toLowerCase().contains(query.toLowerCase())).toList();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final genre = filtered[index];
                          final isSelected = temporary.contains(genre);
                          return ListTile(
                            title: Text(genre),
                            trailing: isSelected ? Icon(Icons.check, color: Colors.green,) : null,
                            onTap: () {
                              setState((){
                                if (isSelected) {
                                  temporary.remove(genre);
                                } else {
                                  temporary.add(genre);
                                }
                              });
                            },
                          );
                        }
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop(temporary);
                      },
                      child: Text("Done")
                  )
                ],
              );
            }
        );
      }
    );
  }
}