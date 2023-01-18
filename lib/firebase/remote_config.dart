import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


class RemoteConfigDemo extends StatefulWidget {
  const RemoteConfigDemo({Key? key}) : super(key: key);

  @override
  State<RemoteConfigDemo> createState() => _RemoteConfigDemoState();
}

class _RemoteConfigDemoState extends State<RemoteConfigDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FirebaseRemoteConfig>(
        future: setupRemoteConfig(),//info is returned i this method and passed in snapshot to get used in below class
        builder: (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {

          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData){
            return Home(remoteConfig: snapshot.requireData);
          }else{
            return const Center(child: Text("No data available"));          }
        }
      ),
    );
  }
}

class Home extends AnimatedWidget {   // animated widget gives listener from which we can listen the changes
  final FirebaseRemoteConfig remoteConfig;

  Home({required this.remoteConfig}) : super(listenable: remoteConfig);

  @override
  Widget build(BuildContext context) {


    var update = remoteConfig.getBool("Update");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote Config"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
              ),
              update?showAlertDialog(context, remoteConfig)
                  : const Center(
                  child: Text("No popup for update")),
              const SizedBox(
                height: 20.0,
              ),
              Image.network(remoteConfig.getString("Image")),
              const SizedBox(
                height: 50.0,
              ),
              Text(
                remoteConfig.getString("Text"),
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(remoteConfig.lastFetchStatus.toString()),
              const SizedBox(
                height: 20.0,
              ),
              Text(remoteConfig.lastFetchTime.toString()),
              const SizedBox(
                height: 20.0,
              ),
              FloatingActionButton(onPressed: () async {
                try {
                  await remoteConfig.setConfigSettings(RemoteConfigSettings(
                      fetchTimeout: const Duration(seconds: 10),
                      minimumFetchInterval: Duration.zero));
                  await remoteConfig.fetchAndActivate();
                  //var temp=remoteConfig.getString("DynamicWidget");
                } catch (e) {
                  debugPrint(e.toString());
                }
              },child: const Icon(Icons.refresh),)
            ],
          ),
        ),
      ),
    );
  }
}


// this method for fetching the information from firebase
Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.fetch();
  await remoteConfig.activate();
  debugPrint(remoteConfig.getString("Text"));

  return remoteConfig;
}


// alert dialog for asking the update
AlertDialog showAlertDialog(BuildContext context, FirebaseRemoteConfig remoteConfig) {
  Widget cancel = TextButton(onPressed: () {}, child: const Text("Cancel"));
  Widget update = TextButton(onPressed: () {}, child: const Text("Update"));

  return AlertDialog(
    title: Text(remoteConfig.getString("Title")),
    content: Text(remoteConfig.getString("Message")),
    actions: <Widget>[cancel, update],
  );
}