import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/consts/colors.dart';
import 'package:wheather_app/consts/images.dart';
import 'package:wheather_app/consts/strings.dart';
import 'package:wheather_app/controller/controller.dart';
import 'package:wheather_app/model/current_weather_model.dart';
import 'package:wheather_app/model/day_weather_model.dart';
import 'package:wheather_app/servies/weather_api.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('yMMMMd').format(DateTime.now());
    var theme = Theme.of(context);
    var controller = Get.put(ThemeController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: date.text.color(theme.primaryColor).size(20).make(),
        actions: [
          Obx(() => IconButton(
              onPressed: () {
                controller.themeChange();
              },
              icon: Icon(
              controller.isDart.value?  Icons.light_mode:Icons.dark_mode,
                color: theme.primaryColor,
              ))),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: theme.primaryColor)),
        ],
      ),
      body:
    Obx(() =>controller.isLoading.value==true?  FutureBuilder(
      future: controller.currentWeatherData,
      builder: (context,AsyncSnapshot snapshot){
         WeatherModelClass data=snapshot.data;
         if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
         }
        if(!snapshot.hasData){
return   "No Data Exit".text.makeCentered();
        }
        return Container(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "${data.name}"
                  .text
                  .size(20)
                  .color(theme.primaryColor)
                  .fontFamily("poppins_bold")
                  .make(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/weather/${data.weather[0].icon}.png",
                    width: 80,
                    height: 80,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "${data.main.temp}$degree",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 60,
                              ))),
                      RichText(
                          text: TextSpan(
                              text: "${data.weather[0].main}",
                              style: TextStyle(
                                letterSpacing: 3,
                                color: theme.primaryColor,
                                fontSize: 14,
                              )))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.expand_less,
                      color: theme.iconTheme.color,
                    ),
                    label: "${data.main.tempMin}$degree".text.color(theme.iconTheme.color).make(),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.expand_more,
                      color: theme.iconTheme.color,
                    ),
                    label: "${data.main.tempMax}$degree".text.color(theme.iconTheme.color).make(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  var images = [clouds, humidity, windspeed];

                  var values = ["${data.clouds.all}", "${data.main.humidity}", "${data.wind.speed}km/h"];
                  return Column(
                    children: [
                      Image.asset(
                        images[index],
                        width: 60,
                        height: 60,
                      ).box.p8.color(cardColor.withOpacity(0.3)).roundedSM.make(),
                      10.heightBox,
                      values[index].text.color(theme.primaryColor).make()
                    ],
                  );
                }),
              ),
              10.heightBox,
              Divider(),
              10.heightBox,
               FutureBuilder(
                future: controller.dayWeatherData,
                builder: (context,AsyncSnapshot snapshot){
                  WeatherDayModelClass data=snapshot.data;
                if(!snapshot.hasData){
                  return "No Data Exit".text.make();
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                return   SizedBox(
                height: 160,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  // itemCount: data.list?.length,
                  itemCount: data.list.length>6?6:data.list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var time=DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(data.list[index].dt*1000));
                    return Container(
                      margin: EdgeInsets.all(4),
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: cardColor.withOpacity(0.3)),
                      child: Column(
                        children: [
                          10.heightBox,
                          "$time".text.gray400.make(),
                          Image.asset("assets/weather/${data.list[index].weather[0].icon}.png"),
                          "${data.list[index].main.temp}$degree".text.gray400.make()
                        ],
                      ),
                    );
                  },
                ),
              );
             
                },
              ),
             
              10.heightBox,
              Divider(),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Next 7 Day".text.color(theme.primaryColor).semiBold.make(),
                  "View All".text.color(theme.primaryColor).make(),
                ],
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  var date = DateFormat("EEEE")
                      .format(DateTime.now().add(Duration(days: index + 1)));
                  return Card(
                    color: theme.cardColor,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: date.text
                                  .color(theme.primaryColor)
                                  .semiBold
                                  .make()),
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/weather/50n.png",
                                  width: 40,
                                ),
                                "26$degree"
                                    .text
                                    .color(theme.primaryColor)
                                    .make()
                              ],
                            ),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "37$degree/",
                                style: TextStyle(color: theme.primaryColor)),
                            TextSpan(
                                text: "26$degree",
                                style: TextStyle(color: theme.primaryColor)),
                          ]))
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
   
      },
     ):Center(child: CircularProgressIndicator(),)
   )
    );
  }
}
