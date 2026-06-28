# Hardware

> Lista de componentes em nível **genérico** (modelo/chip), para fins técnicos. Sem
> fornecedores, links, quantidades ou preços — isso fica fora do repositório.

## Componentes por ponto (1 unidade controla 1 ambiente)

| Função | Componente | Observação |
|---|---|---|
| Placa + tela + toque | **ESP32-2432S028R** (Cheap Yellow Display, "CYD") | 2.8", ILI9341 240×320, toque resistivo XPT2046, micro-USB |
| Sensor de ambiente | **AHT20 + BMP280** (I²C) | temperatura, umidade e pressão barométrica em um módulo |
| Emissor IR | **LED infravermelho 940 nm** | aponta para o aparelho de ar-condicionado |
| Driver do LED IR | **transistor NPN 2N2222** + resistor de base | dá corrente/alcance ao LED (GPIO sozinho é fraco) |
| Receptor IR (opcional) | **VS1838B** (38 kHz) | para *capturar* códigos de controles antigos e como gatilho permanente |
| Passivos | **resistores 1/4 W** (sortidos) | base do transistor, limitador do LED, pull-ups se necessário |
| Ligações | **jumpers dupont** (fêmea-fêmea e macho-fêmea) | conexão sem solda nos headers do CYD |
| Alimentação | **fonte USB 5 V** | adquirida no Brasil; ver "Alimentação" abaixo |

> Os WiFi-nativos (alguns ACs e o módulo Midea/Springer com WiFi) **não usam** este hardware —
> são controlados por integração local direta no Home Assistant. Ver
> [firmware.md](firmware.md).

## Pinagem do CYD (ESP32-2432S028R)

O CYD já usa internamente vários GPIOs (display, toque, backlight, LED RGB, LDR, SD). Os pinos
**livres** ficam expostos nos conectores laterais (rotulados tipo `CN1`, `P3`, `P1` conforme a
revisão). Sempre confira o silk da sua placa antes de soldar.

| Recurso | GPIO típico | Tipo | Uso no climatouch |
|---|---|---|---|
| I²C SDA | GPIO21 | I/O | sensor AHT20+BMP280 |
| I²C SCL | GPIO22 | I/O | sensor AHT20+BMP280 |
| Saída IR | GPIO27 *(ou outro livre)* | saída | base do transistor do LED IR |
| Entrada IR | GPIO35 | **entrada apenas** | receptor VS1838B (captura) |
| LDR (luz) | GPIO34 | entrada/ADC | já embutido — auto-brilho |
| LED RGB | GPIO4 / GPIO16 / GPIO17 | saída | já embutido — status |
| Botão BOOT | GPIO0 | entrada | já embutido — ação rápida |

> ⚠️ GPIO34/35 são **input-only** (sem pull-up interno e sem saída). Use GPIO35 para o receptor
> IR e um pino com saída (ex.: GPIO27) para o emissor.

## Ligação do emissor IR (LED + 2N2222)

```
GPIO (saída) --[ R base ~220-1k ]--> Base (B) do 2N2222
                                     Coletor (C) --> LED IR (catodo)
                                     Emissor (E) --> GND
                          LED IR (anodo) --[ R ~100 ohm ]--> 5V (ou 3V3)
```

- O transistor chaveia o LED; o GPIO só controla a base (corrente baixa, seguro).
- Resistor de base limita a corrente do GPIO; resistor em série com o LED limita a corrente do
  LED. Valores finais a calibrar na bancada (alcance vs. consumo).
- Para mais alcance, dois LEDs IR em série/paralelo com o resistor ajustado.

## Ligação do sensor (AHT20+BMP280)

- `VCC → 3V3`, `GND → GND`, `SDA → GPIO21`, `SCL → GPIO22`.
- Ambos os chips ficam no mesmo barramento I²C (endereços diferentes), um único par de fios.

## Alimentação

- Energização pelo conector **JST VIN/5V** do CYD (mantém o gabinete compacto, sem o micro-USB
  lateral aparecendo) **ou** simplesmente pelo micro-USB.
- ⚠️ O CYD tem conectores JST parecidos com tensões diferentes — **conferir o rótulo**: ligar
  5 V num pino de 3,3 V queima a placa. (Ver `3d_print/ESP32-2432S028/ASSEMBLY.md`.)
- Fonte USB 5 V e cabo são comprados no Brasil (fora deste repositório).
