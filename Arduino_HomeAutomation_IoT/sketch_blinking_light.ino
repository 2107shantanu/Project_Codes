void setup() {
  // put your setup code here, to run once:
pinMode(12,OUTPUT);
pinMode(11,OUTPUT);
pinMode(9,OUTPUT);
pinMode(8,OUTPUT);
pinMode(6,OUTPUT);
pinMode(5,OUTPUT);
pinMode(1,OUTPUT);
pinMode(2,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(1,LOW);
  digitalWrite(2,HIGH);
  delay(5000);
  digitalWrite(2,LOW);
  digitalWrite(1,HIGH);
  digitalWrite(5,LOW);
  digitalWrite(6,HIGH);
  delay(5000);
  digitalWrite(6,LOW);
  digitalWrite(5,HIGH);
  digitalWrite(8,LOW);
  digitalWrite(9,HIGH);
  delay(6000);
  digitalWrite(9,LOW);
  digitalWrite(8,HIGH);
  digitalWrite(11,LOW);
  digitalWrite(12,HIGH);
  delay(4000);
  digitalWrite(12,LOW);
  digitalWrite(11,HIGH);
}
