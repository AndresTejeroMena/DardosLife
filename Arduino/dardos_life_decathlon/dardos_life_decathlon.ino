// Define los pines de salida digitales
const int salidaPinesDigitales[] = {2, 3, 4, 5, 6, 7, 8};  // Cambia según tus pines disponibles
const int numSalidaPinesDigitales = 7;

// Define los pines de entrada digitales
const int entradaPinesDigitales[] = {9, 10, 11, 12    };  // Cambia según tus pines disponibles
const int numEntradaPinesDigitales = 4;

// Define los pines de entrada analógicos
const int entradaPinesAnalogicos[] = {A1, A2, A3, A4, A5, A6};  // Cambia según tus pines disponibles
const int numEntradaPinesAnalogicos = 6;

// Define el umbral para la detección analógica
const int umbral = 500;

// Define la estructura para representar cada celda de la matriz
struct CeldaDiana {
  int numero;
  char tipo;
};

// Define la matriz 7x10 para representar la disposición de la diana
CeldaDiana matrizDiana[7][10] = {
  {{17, 'T'}, {3, 'T'}, {19, 'T'}, {7, 'T'}, {2, 'T'}, {15, 'T'}, {16, 'T'}, {8, 'T'}, {11, 'T'}, {14, 'T'}},
  {{17, 'D'}, {3, 'D'}, {19, 'D'}, {7, 'D'}, {2, 'D'}, {15, 'D'}, {16, 'D'}, {8, 'D'}, {11, 'D'}, {14, 'D'}},
  {{17, 'S'}, {3, 'S'}, {19, 'S'}, {7, 'S'}, {2, 'S'}, {15, 'S'}, {16, 'S'}, {8, 'S'}, {11, 'S'}, {14, 'S'}},
  {{0, 'D'}, {0, 'S'}, {0, 'S'}, {0, 'S'}, {0, 'D'}, {0, 'S'}, {0, 'T'}, {0, 'S'}, {25, 'S'}, {25, 'D'}},
  {{13, 'S'}, {4, 'S'}, {18, 'S'}, {1, 'S'}, {6, 'S'}, {10, 'S'}, {20, 'S'}, {5, 'S'}, {12, 'S'}, {9, 'S'}},
  {{13, 'D'}, {4, 'D'}, {18, 'D'}, {1, 'D'}, {6, 'D'}, {10, 'D'}, {20, 'D'}, {5, 'D'}, {12, 'D'}, {9, 'D'}},
  {{13, 'T'}, {4, 'T'}, {18, 'T'}, {1, 'T'}, {6, 'T'}, {10, 'T'}, {20, 'T'}, {5, 'T'}, {12, 'T'}, {9, 'T'}}
};

void setup() {
  Serial.begin(9600);  // Inicializa la comunicación serial
  while (!Serial);

  for (int i = 0; i < numSalidaPinesDigitales; ++i) {
    pinMode(salidaPinesDigitales[i], OUTPUT);
  }
}

void loop() {
  for (int i = 0; i < numSalidaPinesDigitales; ++i) {
    digitalWrite(salidaPinesDigitales[i], HIGH);

    // Lee las entradas digitales
    for (int j = 0; j < numEntradaPinesDigitales; ++j) {
      int estadoDigital = digitalRead(entradaPinesDigitales[j]);

      // Si hay un contacto, imprime la información en el monitor serial
      if (estadoDigital == HIGH) {
        CeldaDiana celda = matrizDiana[i][j];
        Serial.print(celda.numero);
        Serial.print(":");
        Serial.println(celda.tipo);
        delay(500);
      }
    }

    // Lee las entradas analógicas
    for (int k = 0; k < numEntradaPinesAnalogicos; ++k) {
      int lecturaAnalogica = analogRead(entradaPinesAnalogicos[k]);

      // Si hay un contacto, imprime la información en el monitor serial
      if (lecturaAnalogica > umbral) {
        CeldaDiana celda = matrizDiana[i][k + numEntradaPinesDigitales];
        Serial.print(celda.numero);
        Serial.print(":");
        Serial.println(celda.tipo);
        delay(500);
      }
    }

    digitalWrite(salidaPinesDigitales[i], LOW);
  }
}
