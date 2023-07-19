
import 'package:flutter/material.dart';

int total_balance = 0;
bool islist = false;
bool isadd =false;
List<expense_entry> showup=[];



void main() {
  runApp(const MaterialApp(
  home: my_app(),
));}

class my_app extends StatefulWidget {
  const my_app({super.key});

  @override
  State<my_app> createState() => _my_appState();
}

class _my_appState extends State<my_app> {
  void show_list() {
    setState(() {
      islist = true;
    });
  }
  void go_back() {
    setState(() {
      islist = false;
    });
  }
  void show_add() {
    setState(() {
      isadd = true;
    });
  }
  void go_back_add() {
    setState(() {
      isadd = false;
    });
  }
  void add_entry(String cat,int pri){
    setState(() {
      expense_entry se =expense_entry(cat, pri);
      showup.add(se);
      total_balance+=pri;
    });
  }
  void rem_exp(expense_entry se){
    setState(() {
      total_balance =total_balance - se.price!;
      showup.remove(se);
    });
  }
  @override
  Widget build(BuildContext context) {
    return isadd ? addexpense(go_back_add,add_entry) : (islist ? expenses(go_back,show_add,rem_exp) : mainhome(show_list,show_add));
  }
}

Scaffold mainhome(VoidCallback onPressed1,VoidCallback onPressed2){
  return Scaffold(
    backgroundColor: Colors.grey[900],
    appBar: AppBar(
      title: const Text('Budget Tracker'),
      centerTitle: true,
      backgroundColor: Colors.grey[700],
    ),
    body: Container(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              'Welcome Back\n User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 80.0),
              decoration: BoxDecoration(
                color: Colors.white, // Box background color
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              child: Text(
                'Total Budget\n $total_balance',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ],
        ),
      ),
    ),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: onPressed1,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.keyboard_double_arrow_down_rounded,
            size: 60.0,
          ),
        ),
        SizedBox(width: 5.0),
        FloatingActionButton(
          onPressed: onPressed2,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add_circle_outline,
            size: 60.0,
          ),
        ),
      ],
    ),
  );
}

Scaffold expenses(VoidCallback onPressed1,VoidCallback onPressed2,void Function(expense_entry) onPressed3){
  return Scaffold(
    backgroundColor: Colors.grey[900],
    appBar: AppBar(
      title: const Text('Budget Tracker: Expenses'),
      centerTitle: true,
      backgroundColor: Colors.grey[700],
    ),
    body: Container(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 80.0),
              decoration: BoxDecoration(
                color: Colors.white, // Box background color
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              child: Text(
                'Total Budget\n $total_balance',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ...showup.map((item) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                margin: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text('${item.category}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),),
                    SizedBox(width: 30.0),
                    Text('${item.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    Spacer(),
                    IconButton(onPressed: (){onPressed3(item);}, icon: Icon(Icons.delete_forever))
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    ),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: onPressed1,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.keyboard_double_arrow_left_rounded,
            size: 60.0,
          ),
        ),
        SizedBox(width: 5.0),
        FloatingActionButton(
          onPressed: onPressed2,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add_circle_outline,
            size: 60.0,
          ),
        ),
      ],
    ),
  );
}

Scaffold addexpense(VoidCallback onPressed1,void Function(String, int) onPressed2){
  final text_controller1 = TextEditingController();
  final text_controller2 = TextEditingController();
  return Scaffold(
    backgroundColor: Colors.grey[900],
    appBar: AppBar(
      title: const Text('Budget Tracker: Add Expenses'),
      centerTitle: true,
      backgroundColor: Colors.grey[700],
    ),
    body: Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            child: TextField(
              controller: text_controller1,
              decoration: InputDecoration(
                hintText: 'Category',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: (){text_controller1.clear();}, icon: Icon(Icons.clear)),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(signed: true),
              controller: text_controller2,
              decoration: InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: (){text_controller2.clear();}, icon: Icon(Icons.clear)),
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: onPressed1,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.clear_rounded,
            size: 60.0,
          ),
        ),
        SizedBox(width: 5.0),
        FloatingActionButton(
          onPressed: (){
            onPressed2(text_controller1.text,int.parse(text_controller2.text));
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add_circle_outline,
            size: 60.0,
          ),
        ),
      ],
    ),
  );
}

class expense_entry{
  String? category;
  int? price;
  expense_entry(String category,int price){
    this.category=category;
    this.price=price;
  }
  @override
  String toString() {
    return 'Category: $category, Price: $price';
  }
}
