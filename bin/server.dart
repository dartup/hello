library hello;

import 'dart:io';

//Dartup will call my application with server.dart no arguments
main(){
  // If port is not supplied. Set it to 8080 for local debugging;
  int port = 8080;

  // Get port from DARTUP_PORT if available.
  if(Platform.environment.containsKey('DARTUP_PORT')){
    port = int.parse(Platform.environment['DARTUP_PORT']);
  }

  //Dartup will connect from localhost.
  HttpServer.bind(InternetAddress.LOOPBACK_IP_V4,port).then((HttpServer server){
    server.listen((HttpRequest req){
      var body = new StringBuffer();
      body.writeln('<html>');
      body.writeln('<head><title>Hello Dartup</title></head>');
      body.writeln('<body>');
      //If you run in Dartup the environment variable 'DARTUP' will be set to 1.
      if(Platform.environment['DARTUP'] == '1'){
        body.writeln('<h1>Hello world from Dartup</h1>');
        //You will also have the hosted domain available. In this case hello.dartup.io.
        body.writeln('I am currently running on ${Platform.environment['DARTUP_DOMAIN']}.');
      }else{
        body.writeln('<h1>Hello world from localhost</h1>');
        body.writeln('How dare you run me here of all places!');
      }

      req.response.headers.contentType = ContentType.HTML;
      req.response.write(body);
      req.response.close();
    });
  });
}
