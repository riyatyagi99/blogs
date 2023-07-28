import 'package:blog/notification/service.dart';
import 'package:flutter/material.dart';

class LocalNotification extends StatefulWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Local Notifications")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
            child: const Text('Show notifications'),
            onPressed: () {
              NotificationService().showNotification(
                  title: 'Local Notification check',
                  body: "Yey!! It is working");
            },
          )),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            child: const Text('Scheduled notifications'),
            onPressed: () {
              NotificationService().scheduleNotification(
                  title: 'Local scheduled Notification check',
                  body: "Hurray!! It is working",
                scheduledDate: DateTime.now().add(Duration(seconds: 2))

              );
            },
          ) ,
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            child: const Text('Grouped notifications'),
            onPressed: () {
              NotificationService().showGroupedNotifications(title: "Group");
            },
          )
        ],
      ),
    );
  }
}
