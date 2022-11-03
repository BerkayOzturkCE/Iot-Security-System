#include <EEPROM.h>

#include <ArduinoJson.h>



#include <ESP8266WiFi.h>

String ssid     = wifiname
String password = "password";

const char* host = "host";
String Duty = "";
String okunan = "";



void setup() {
  Serial.begin(115200);
  delay(10);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED)
  {
delay(500);
  }


}

void loop() {

  if (Serial.available() > 0) {

    String Str = Serial.readString();
    okunan = "";
    split(Str);
    if (Duty == "0") {
      KartKontrol(okunan);
    } else if (Duty == "1")  {
      kaydet(okunan);
    } else if (Duty == "2") {
      KartEkle(okunan);
    } 
  }


}
void KartEkle(String url) {

  WiFiClientSecure client;
  const int httpPort = 443; // 80 is for HTTP / 443 is for HTTPS!

  client.setInsecure(); // this is the magical line that makes everything work

  if (!client.connect(host, httpPort)) { //works!
    return;
  }

  // This will send the request to the server
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");
}

void KartKontrol(String url) {

  WiFiClientSecure client;
  char c;
  String json;
  const int httpPort = 443; // 80 is for HTTP / 443 is for HTTPS!

  client.setInsecure(); // this is the magical line that makes everything work

  if (!client.connect(host, httpPort)) { //works!
    return;
  }

  // Send HTTP request
  client.println(String("GET ") + url + " HTTP/1.0\r\n" + "Host: " + host + "\r\nConnection: close\r\n"); // HTTP 1.0 pour éviter les réponses découpées (chunked) / Use HTTP 1.0 to avoid chunked answers
  if (client.println() == 0) {
    return;
  }

  while (client.connected())  // Get header: "OK 200... " ==> need to add  header validity check (err 404, etc)

  {
    String line = client.readStringUntil('\n');
    if (line == "\r")
    {
      break;
    }
  }

  while (client.available())   // FOR NOW, JUST PRINT RECEIVED RAW JSON FILE, BUF FILE IS NOT COMPLETE !! (+/-1440 chars out of +/-54151 chars)
  {
    c = client.read();
    json += c;
  }
  StaticJsonDocument<96> doc;

  DeserializationError error = deserializeJson(doc, json);

  if (error) {
    return;
  }

  const char* id = doc["id"]; // "22081998"
  const char* name = doc["name"]; // "ankarakart"

  Serial.print(id);



}


void kaydet(String url)
{


  WiFiClientSecure client;
  const int httpPort = 443; // 80 is for HTTP / 443 is for HTTPS!

  client.setInsecure(); // this is the magical line that makes everything work

  if (!client.connect(host, httpPort)) { //works!
    return;
  }

  // This will send the request to the server
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" +
               "Connection: close\r\n\r\n");



}


void split(String c) {
  int sayac = 0, i = 0;
  while (5) {
    if (c[i] == '|') {
      sayac++;
      if (sayac == 2) {
        break;
      } else {
        i++;
        continue;
      }
    }
    if (sayac == 0) {
      Duty = c[i];
    }
    if (sayac == 1) {
      okunan += c[i];
    }

    i++;

  }

}
