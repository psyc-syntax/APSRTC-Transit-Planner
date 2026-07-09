import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/data_includes_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/data_version_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/database_size_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/top_title.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/update_data_buttoon.dart';

class UpdateDataScreen extends StatelessWidget{
    const UpdateDataScreen({super.key});

    @override
  Widget build(BuildContext context) {

    return Scaffold(
       
          floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal:16,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  
                ),
                child: UpdateDataButton()
              ),
            ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
            top: true,
            bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                    TopTitle(),
                    
                    
            
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            DataVersionBlock(),
                            SizedBox(height: 10,),
                                    
                        DatabaseSizeBlock(),
                                    
                        SizedBox(height: 10,),
                                    
                        DataIncludesBlock(),
                                    
                                    
                        SizedBox(height: 100,),
                          ],
                        ),
                      ),
                    ),
            
                   
            
                    
                ],
            ),
          ),
        ),
    ); 
  }
}

