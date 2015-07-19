library hello;

import 'dart:io';
import 'package:dartup/dartup.dart' as dartup;

// Dartup will call my application with server.dart no arguments
main() async{
  // Gets a HttpServer. We just use the default values localhost:8080 for local runs.
  HttpServer server = await dartup.bind();
  server.listen((HttpRequest req){
    var body = new StringBuffer();
    body.writeln('<html>');
    body.writeln('<head><title>Hello Dartup</title></head>');
    body.writeln('<body>');
    //Test if we are running at Dartup.
    if(dartup.onDartup()){
      body.writeln('<h1>Hello world from Dartup</h1>');
      //You will also have the hosted domain available. In this case hello.dartup.io.
      body.writeln('I am currently running on ${dartup.mainDomain()}.<br>');
      body.writeln('And i am upgradeable');
    }else{
      body.writeln('<h1>Hello world from localhost</h1>');
      body.writeln('How dare you run me here of all places!');
    }

    req.response.headers.contentType = ContentType.HTML;
    req.response.write(body);
    req.response.close();
  });
}
