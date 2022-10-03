import 'package:asbeza_app/screens/profilePage/profileHome.dart';
import 'package:flutter/material.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  bool isOn = false;

  void setNotificationsState(bool value) {
    setState(() {
      isOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setNotificationsState(!isOn);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: leftPadding,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  isOn ? 'On' : 'Off',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Switch(
              value: isOn,
              onChanged: setNotificationsState,
              activeColor: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
