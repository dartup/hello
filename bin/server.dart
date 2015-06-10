library hello;

import 'dart:io';

//Dartup will call my application with server.dart --port XXXX
main(List<String> args){
  // If port is not supplied. Set it to 8080 for local debugging;
  int port = 8080;

  // don't want to depend on the args package so i know that port is argument 3 (item 2 in the list.)
  if(args.length >= 3){
    port = int.parse(args[2]);
  }

  //Dartup will connect from localhost.
  HttpServer.bind(InternetAddress.LOOPBACK_IP_V4,port).then((HttpServer server){
    server.listen((HttpRequest req){
      var body = new StringBuffer();
      body.writeln('<html>');
      body.writeln('<head><title>Hello Dartup</title></head>');
      body.writeln('<body>');
      //If you run in Dartup the environment variable 'DARTUP' will be set to 1.
      if(new String.fromEnvironment('DARTUP') == '1'){
        body.writeln('<h1>Hello world from Dartup</h1>');
        //You will also have the hosted domain available. In this case hello.dartup.io.
        body.writeln('I am currently running on ${String.fromEnvironment('DARTUP_DOMAIN')}');
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
