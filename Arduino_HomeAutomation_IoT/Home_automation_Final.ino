#include <SoftwareSerial.h>                        //Librarey for serial connection with ESP

SoftwareSerial espSerial(2,3);                     //ESP is connected to 12 and 13 pin of Arduino
 
String sendData = "GET https://api.thingspeak.com/channels/1115195/feeds.json?results=2";
String output = ""; //Initialize a null string variable 
String wifiname = "Redmi Note 7S";
String pass = "123456";

#define Relay1 6


void setup() 
{
  pinMode(Relay1,OUTPUT);
  delay(2000);

  Serial.begin (9600);
  delay(100);
  espSerial.begin(9600);
  espCommand("AT",1000);
  espCommand("AT+RST",1000);
  espCommand("AT+CWMODE=1",5000);
  espCommand("AT+CWJAP=\""+ wifiname +"\",\""+pass+"\"",10000);
    Serial.println("Wifi Connected"); 
    delay(1000);  
    }

void loop() {

  String cmd = "AT+CIPSTART=\"TCP\",\"";                // Establishing TCP connection// AT+CIPSTART=4,"TCP","google.com",80
 cmd += "184.106.153.149";                             //  api.thingspeak.com
 cmd += "\",80";                                       // port 80
  espCommand(cmd,1000);
    delay(100); 
    espCommand("AT+CIPSEND=76",1000);  
    delay(100);
  output = "";
    espCommand(sendData,1000);
    delay(100);

  char incoming_value=output[126];
    Serial.print("incoming_value is : ");   
    Serial.println(incoming_value);
    if (incoming_value == '0')                        //light should be off
    { 
      digitalWrite(Relay1,LOW);
    }
    if (incoming_value == '1')                       //light should be on
    { 
      digitalWrite(Relay1,HIGH);
    }
}
void espCommand(String AT_cmd, const int timeout)
{
  
  Serial.print("Sent: ");
  Serial.print(AT_cmd);
  espSerial.println(AT_cmd);                           //print to ESP through software serial 
  Serial.println("");                                  //Move to next line 
  
  
  long int time = millis();

  output="";                                           //clear the string
  
  while ( (time + timeout) > millis())
  {
    while (espSerial.available())
    {
      char i = espSerial.read();                       // read one char 
      output += i;                                     //Combine char to string 
    }
  }
  
  Serial.println("Received: ");
  Serial.print(output);
  
}
