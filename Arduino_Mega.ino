#include <EEPROM.h>

#include <LiquidCrystal.h>
#include<SPI.h>
#include<MFRC522.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
Adafruit_SSD1306 display;

int RST_PIN = 49;
int SS_PIN = 53;
bool aktifmi = false, uyari = false, Bldrm = false;
int Kled = 40, Yled = 44, Buzzer = 5, page = 0;
int GazSensor = A15;
unsigned long eskiZmn = 0;
unsigned long yeniZmn;
String User = "", mes = "";

MFRC522 rfid(SS_PIN, RST_PIN);



void setup() {
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  Wire.begin();
  pinMode(Kled, OUTPUT);
  pinMode(Yled, OUTPUT);
  pinMode(12, INPUT);
  pinMode(8, INPUT);
 int newStrLen = EEPROM.read(10);  Serial.println(newStrLen);
delay(1000);
  char data[newStrLen + 1];
  for (int i = 0; i < newStrLen; i++)
  {
   data[i]  = EEPROM.read(10 + 1 + i);
    User+=data[i];  Serial.println(data[i]);

  } data[newStrLen] = '\ 0';
  Serial.println(data);

  pinMode(Buzzer, OUTPUT);
  Serial3.begin(115200);
  Serial.begin(9600);
  Serial2.begin(9600);

  SPI.begin();
  rfid.PCD_Init();
  analogWrite(6, 90);
  lcd_yazi();
  attachInterrupt(0, ButtonClick, RISING);

}

void loop() {

  if (page == 0) {
    lcd_yazi();
    while (rfid.PICC_IsNewCardPresent()) {
      if (rfid.PICC_ReadCardSerial()) {
 eskiZmn = millis();
yeniZmn= millis();        Bldrm = true;

        kart_bilgi_al();
      } else {
        break;
      }
    }


    if (aktifmi) {
      yeniZmn = millis();
      if (yeniZmn - eskiZmn > 10000 && Bldrm == true) {
        eskiZmn = yeniZmn;
        BldrmGonder();
        Bldrm = false;
      }
      if (digitalRead(12) == true && Bldrm == false) {
        Bldrm = true;
        digitalWrite(Kled, HIGH);
        digitalWrite(Buzzer, HIGH);
        display.clearDisplay();
        display.setCursor (5, 5);
        display.print("Bir Hareket\nAlgilandi");
        display.display();

        delay(1000);
        digitalWrite(Kled, LOW);
        digitalWrite(Buzzer, LOW);
        lcd_yazi();
      }
    }
    Serial.println(analogRead(A15));

    if (analogRead(A15) > 400) {
      digitalWrite(Kled, HIGH);
      digitalWrite(Buzzer, HIGH);
      display.clearDisplay();
      display.setCursor (5, 5);
      display.print("Yanici gaz algilandi");
      display.display();

      delay(1000);
      digitalWrite(Kled, LOW);
      digitalWrite(Buzzer, LOW);
      lcd_yazi();
    }
  } else {
    KartEkle();

  }

  if (Serial2.available() > 0) {
    String c = Serial2.readString();    Serial.println(c);

    mes = "";
    User = "";
    int sayac = 0, i = 0;
    while (5) {
      if (c[i] == '&') {
        sayac++;
        if (sayac == 2) {
          break;
        } else {
          i++;
          continue;
        }
      }
      if (sayac == 0) {
        User += c[i];
      }
      if (sayac == 1) {
        mes += c[i];
      }

      i++;

    }
      Serial.println(User);

int addrOffset=10;
 byte len = User.length();      Serial.println(len);

  EEPROM.write(addrOffset, len);
  for (int i = 0; i < len; i++)
  {
    EEPROM.write(addrOffset + 1 + i, User[i]);
  }
    

  }







}

void ButtonClick() {
  if (page == 0&&aktifmi==false) {
    page = 1;
  } else {
    page = 0;
  }
}

void KartEkle() {
  display.clearDisplay();
  display.setCursor (5, 5);
  display.println("Yeni Eklenecek"); display.println("Karti Okutun.");  display.display();

  while (rfid.PICC_IsNewCardPresent()) {
    if (rfid.PICC_ReadCardSerial()) {
      String url = "2|/api/values/2&us12&";
      String CartId = "";
      CartId += rfid.uid.uidByte[0];
      CartId += rfid.uid.uidByte[1];
      CartId += rfid.uid.uidByte[2];
      CartId += rfid.uid.uidByte[3];
      url += CartId;
      url += "|";
      Serial3.println(url);

      display.clearDisplay();
      display.setCursor (5, 5);
      display.println("Kart Ekleniyor..."); display.display();
      delay(2000);

      display.clearDisplay();
      display.setCursor (5, 5);
      display.println("Kart Eklendi..."); display.display();
      delay(1000);
      page = 0;
    } else {
      break;
    }
  }


}


void lcd_yazi() {
  display.clearDisplay();
  display.setTextColor(WHITE);
  display.setTextSize(1);
  display.setCursor(5, 5);
  display.println("Lutfen Kartinizi");
  display.print("Okutun");


  display.display();
}

String CartControl(String CartId) {
  Serial3.println(CartId);


  while (5) {
    if (Serial3.available() > 0) {

      return Serial3.readString();
    }
  }

}

void kart_bilgi_al() {
  display.clearDisplay();
  display.setCursor (5, 5);
  display.println("Kart Kontrol");    display.println("Ediliyor...");  display.display();


  String url = "0|/api/values/0&us12&";
  String CartId = "";
  CartId += rfid.uid.uidByte[0];
  CartId += rfid.uid.uidByte[1];
  CartId += rfid.uid.uidByte[2];
  CartId += rfid.uid.uidByte[3];
  url += CartId;
  url += "|";
  String onay = CartControl(url);
  url = "1|/api/values/1&us12&";
  url += CartId;
  display.clearDisplay();
  display.setCursor (5, 5);
    Serial.println(onay);
    Serial.println(CartId);

  if (CartId.equals(onay)) {
    url += "&Gecerli|";
    display.println("Kart Onaylandi");
    Bldrm = false;
    digitalWrite(Yled, HIGH);
    if (aktifmi) {
      aktifmi = !aktifmi;
      display.print("Sistem Deaktif");
    } else {
      aktifmi = !aktifmi;
      display.print("Sistem Aktif");
    }
    display.display();

    delay(2000);
    digitalWrite(Yled, LOW);

  } else {
    url += "&Gecersiz|";
    display.print("Tanimsiz Kart");
    digitalWrite(Kled, HIGH);
    digitalWrite(Buzzer, HIGH);
    display.display();

    delay(2000);
    digitalWrite(Kled, LOW);
    digitalWrite(Buzzer, LOW);

  }
  Serial3.println(url);

  rfid.PICC_HaltA();
  lcd_yazi();
}

void BldrmGonder() {

}
