# Proyecto 1 - Batalla Naval

## IIC3745 - Testing

## Integrantes

| Nombre              | Email               | Usuario de Github                                      |
| :------------------ | :------------------ | :----------------------------------------------------- |
| Luciano Chiang      | lachiang@uc.cl      | [@lucianoandresch](https://github.com/lucianoandresch) |
| Mauricio Pinto      | mepinto1@uc.cl      | [@mauriciopc1](https://github.com/mauriciopc1)         |
| José Tort           | jatort@uc.cl        | [@jatort](https://www.github.com/jatort)               |
| Ariela Valenzuela   | Asvalenzuela1@uc.cl | [@ariela1](https://github.com/ariela1)                 |
| Carolina Valenzuela | cfvalenzuela1@uc.cl | [@Cfvalenzuelar](https://github.com/Cfvalenzuelar)     |

## Descripción de la distribución del repositorio

El repositorio actualmente se distribuye en tres carpetas principales: _test_ y _coverage_ consideran los test unitarios ejecutados sobre la aplicación y su cobertura respectivamente, mientras que el código en _lib_ abarca la lógica del juego.

## Instalación

Para asegurar la ejecución del programa se debe contar con ruby versión 2.7.0 instalada, posteriormente se debe correr el siguente comando para la instalación de dependencias:
`bundler install`

## ¿Cómo ejecutar la aplicación?

Para ejecutar el proyecto debe ejecutarse en consola, dentro de la carpeta lib, la siguiente instrucción:
`ruby main.rb`

Para ejecutar los test unitarios y se actualice la carpeta del coverage, se debe ejecutar el siguiente comando en la carpeta raíz:
`rake test`

### Reglas del juego

Inicio del juego: se define el modo de juego, puede ser

1. Contra el computador
2. Uno contra uno

Se define luego la dificultad, puede ser estándar o difícil, se detalla más adelante las implicancias de cada dificultad.

Luego se pide al jugador que coloque los barcos (solo horizontal y vertical). No deben solaparse entre ellos.

Los jugadores pueden disparar por turnos a los barcos de su oponente, en caso
de darle a algún barco, el turno de quien disparó se debe repetir.

Un barco se considera “hundido”, cuando ha recibido un disparo en cada una de las casillas
que conforman dicha embarcación. Se informa al jugador cada vez que un barco sea hundido.

El juego termina cuando todos los barcos de uno de los jugadores fueron hundidos (todas las casillas con barcos recibieron un disparo).

El tablero definirá sus coordenadas según letras y números dispuestos en la parte superior y a los costados, la vista será como el siguiente ejemplo:

**<ins>Dificultad estándar</ins>**

- Tamaño del tablero: 10x10
- Cantidad de barcos:

  - 1 de largo 5
  - 1 de largo 4
  - 2 de largo 3
  - 1 de largo 2

**<ins>Nivel de dificultad 2</ins>**
Tamaño del tablero: 15x15
Cantidad de barcos:

    - 2 de largo 5
    - 2 de largo 4
    - 2 de largo 3
    - 2 de largo 2
