import "package:flutter/material.dart";
class RenterChat extends StatefulWidget {
  const RenterChat({super.key});

  @override
  State<RenterChat> createState() => _RenterChatState();
}

class _RenterChatState extends State<RenterChat> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Color.fromRGBO(12, 10, 49, 1),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          labelColor: Colors.black,
          tabs: [
            Tab(text: "Active",),
            Tab(text: "Complete",),
          ]),
        body: TabBarView(children: [
          RenterOrderActive(),
          RenterOrderComplete()
        ]),
      ),
    );
  }
}

class RenterOrderActive extends StatefulWidget {
  const RenterOrderActive({super.key});

  @override
  State<RenterOrderActive> createState() => _RenterOrderActiveState();
}

class _RenterOrderActiveState extends State<RenterOrderActive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ContainerCustomeShadowOrder(),
        ],
      ),
    );
  }
}

class RenterOrderComplete extends StatefulWidget {
  const RenterOrderComplete({super.key});

  @override
  State<RenterOrderComplete> createState() => _RenterOrderCompleteState();
}

class _RenterOrderCompleteState extends State<RenterOrderComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("No orders have been completed yet"),
          )
        ],
      ),
    );
  }
}

class ContainerCustomeShadowOrder extends StatefulWidget {
  ContainerCustomeShadowOrder({
    super.key,
  });

  @override
  State<ContainerCustomeShadowOrder> createState() => _ContainerCustomeShadowOrderState();
}

class _ContainerCustomeShadowOrderState extends State<ContainerCustomeShadowOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            child: Image(image: AssetImage("images/carsItem.png")),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Honda Brio", style: TextStyle(fontWeight: FontWeight.w800),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time Remaining", style: TextStyle(fontSize: 14),),
                        Text("21:43: 29", style: TextStyle(fontSize: 14),),
                      ],
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onPressed: (){
                          
                          },
                          child: Text("Done")),
                    )

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

