import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashbord/widget/addbutton.dart';
// import 'package:flutter_application_1/dashbord/widget/editbutton.dart';
import 'package:flutter_application_1/dashbord/widget/opreation.dart';
import 'package:flutter_application_1/dashbord/widget/tablehedar.dart';

class Toustion extends StatefulWidget {
  const Toustion({super.key});

  @override
  State<Toustion> createState() => _ToustionState();
}

class _ToustionState extends State<Toustion> {
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Hederbardashbord(
        //   page_name: 'Research',
        //   button: MyButton(
        //       color: Colors.blue,
        //       titel: 'Add Department',
        //       onpressed: () {

        //       }),
        // ),
        // Headaddfile(
        //   page_anme: 'Toution Page',
        // ),
        Row(
          children: [
            Text('Toustion'),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        Divider(thickness: 0.5, color: Colors.green),
        Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              //HeaderTable
              TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.green, width: 0.5),
                    ),
                  ),
                  children: [
                    // Tablehedar('Department'),

                    Tablehedar(name: 'Department Name'),
                    Tablehedar(name: 'collage'),
                    Tablehedar(name: 'public'),
                    Tablehedar(name: 'privet '),
                    Tablehedar(name: 'privet s'),
                    Tablehedar(name: ''),
                  ]),
            ]),
        //Data Table
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                tabblRow(
                  context,
                  // department: 10,
                  department_name: 'الطب',
                  collage_name: 'الطب',
                  public: '2500',
                  privet: '25000',
                  dean: '20',
                ),
                tabblRow(context,
                    // department: 10,
                    department_name: 'bilal',
                    collage_name: 'الطب',
                    public: '2500',
                    privet: '25000',
                    // image: 'images/كلية العلوم الإدارية .png',
                    dean: 'Ahmed'),
                tabblRow(context,
                    department_name: 'bilal',
                    collage_name: 'الطب',
                    public: '2500',
                    privet: '25000',
                    // image: 'images/كلية العلوم التطبيقية .png',
                    // department: 10,
                    dean: 'Dr.jamal AL Ameri'),
                tabblRow(context,
                    department_name: 'bilal',
                    collage_name: 'الطب',
                    public: '2500',
                    privet: '25000',
                    // image: 'images/managmentscinecie.png',
                    // department: 10,
                    dean: 'Dr.jamal AL Ameri'),
                tabblRow(context,
                    department_name: 'bilal',
                    collage_name: 'الطب',
                    public: '2500',
                    privet: '25000',
                    // image: 'images/كلية الحقوق.png',
                    // department: 10,
                    dean: 'Dr.jamal AL Ameri'),
                tabblRow(
                  context,
                  department_name: 'bilal',
                  collage_name: 'الطب',
                  public: '2500',
                  privet: '25000',
                  // image:
                  //     'images/png-transparent-paper-ink-fountain-pen-ballpoint-pen-pen-and-ink-ink-textile-cosmetics-thumbnail.png',
                  // department: 10,
                  dean: 'Dr.jamal AL Ameri',
                ),
                tabblRow(
                  context,
                  department_name: 'bilal',
                  collage_name: 'الطب',
                  public: '2500',
                  privet: '25000',
                  // image: 'images/كلية التربية ٣.png',
                  // department: 10,
                  dean: 'Dr.jamal AL Ameri',
                ),
                tabblRow(
                  context,
                  department_name: 'bilal',
                  collage_name: 'الطب',
                  public: '2500',
                  privet: '25000',
                  // image: 'images/اللغات والترجمة .png',
                  // department: 10,
                  dean: 'Dr.jamal AL Ameri',
                ),
                tabblRow(
                  context,
                  department_name: 'bilal',
                  collage_name: 'الطب',
                  public: '2500',
                  privet: '25000',
                  // image: 'images/الحاسب الآلي .png',
                  // department: 10,
                  dean: 'Dr.jamal AL Ameri',
                ),
                tabblRow(
                  context,
                  department_name: 'bilal',
                  collage_name: 'الطب',
                  public: '2500',
                  privet: '25000',
                  // image: 'images/كلية العلوم الإدارية .png',
                  // department: 10,
                  dean: 'Dr.jamal AL Ameri',
                ),
              ],
            ),
          ),
        )
        //   ],
        // )
      ]),
    );
  }

  TableRow tabblRow(
    context, {
    department_name,
    public,
    privet,
    dean,
    collage_name,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.green, width: 0.5),
          ),
        ),
        children: [
          // Text('$department'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(1000),
                //   child: Image.asset(
                //     "$image",
                //     // height: 40,
                //     width: 60,
                //   ),
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                Text(department_name),
              ],
            ),
          ),
          Text(collage_name),
          Row(
            children: [
              // Container(
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle, color: AppColors.maincolor),
              //     height: 10,
              //     width: 10),
              SizedBox(
                width: 10,
              ),
              Text(public),
            ],
          ),
          Text(dean),
          Text(privet),
          opreation(isMobile: isMobile,onEdit: (){},onDelete:(){})
        ]);
  }
}
