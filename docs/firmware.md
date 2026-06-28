# Firmware (ESPHome)

> Estratégia de software para o `climatouch`. Nenhum segredo, IP, token ou código IR específico
> de uma residência fica neste repositório — esses valores vão em `secrets.yaml` (não
> versionado) e nas configs locais de cada dispositivo.

## Camadas

1. **Base de interface (herdada do upstream):** as configs `esphome/home-like/` e
   `esphome/buttons/` já entregam a UI LVGL (tiles estilo "Home", brilho, clima na tela).
2. **Controle de ar-condicionado por IR (adição do climatouch):** uma entidade `climate` que
   transmite IR via `remote_transmitter` + um componente de clima.
3. **Sensor de ambiente:** `aht20` + `bmp280` no I²C → temperatura, umidade, pressão.
4. **Funcionalidades grátis:** aproveitando o hardware que já vem (ver fim do documento).

## Controle de AC: nativo vs. captura

O ESPHome tem **protocolos de clima embutidos** — você manda "cool 24°C" e ele gera os bits IR
certos. Quando o aparelho tem protocolo pronto, é só usar. Quando não tem, a gente **captura**
os códigos com o receptor IR (VS1838B) e reproduz com `remote_transmitter`.

### Matriz de aparelhos → caminho

| Aparelho | Caminho | Protocolo / integração | Situação |
|---|---|---|---|
| GREE (linha antiga, sem WiFi) | IR (CYD) | `climate_ir` **`gree`** (nativo ESPHome) | protocolo confiável — **candidato a protótipo** |
| Eletrolux (split, sem WiFi) | IR (CYD) | external component da comunidade **ou** captura IR | a validar |
| Springer (linha antiga, sem WiFi) | IR (CYD) | tentar nativo (`coolix`/`tcl112`/etc.) **ou** captura | a validar por modelo |
| Midea/Springer com WiFi | WiFi local | integração local no HA (`midea_ac_lan`) | **sem ESP32** |
| Marcas com WiFi nativo (ex.: LG/Daikin) | WiFi/cloud do fabricante | integração própria no HA | **sem ESP32** |

> Os controles físicos de todos os aparelhos estão disponíveis, então a **captura é sempre um
> fallback garantido** caso o protocolo nativo não bata.

### Esqueleto da entidade climate (IR nativo)

```yaml
remote_transmitter:
  pin: GPIO27          # base do transistor do LED IR
  carrier_duty_percent: 50%

climate:
  - platform: gree     # trocar pelo protocolo do aparelho
    name: "Ar ${room}"
    model: generic      # conforme o protocolo
    sensor: temp_ambiente   # usa o AHT20 como temperatura atual
```

### Esqueleto para captura (fallback)

```yaml
remote_receiver:
  pin:
    number: GPIO35      # input-only, ideal p/ receptor
    inverted: true
  dump: all             # loga os códigos recebidos para você copiar

# depois de capturar, reproduzir com:
# remote_transmitter + button/select que envia o code salvo
```

## Sensor de ambiente

```yaml
i2c:
  sda: GPIO21
  scl: GPIO22

sensor:
  - platform: aht20
    temperature: { name: "Temperatura ${room}", id: temp_ambiente }
    humidity:    { name: "Umidade ${room}" }
  - platform: bmp280_i2c
    pressure:    { name: "Pressão ${room}", id: pressao }
    temperature: { name: "Temp (BMP) ${room}" }
```

## Funcionalidades grátis (sem custo extra de hardware)

Só software, aproveitando o que o CYD e o sensor já trazem:

- **Pressão barométrica + tendência de tempo** (BMP280): "pressão caindo → tende a chover".
- **Auto-brilho** pelo LDR embutido (GPIO34): escurece a tela à noite / com luz baixa.
- **Bluetooth Proxy + presença BLE** (o ESP32 tem BT): estende o alcance BT do HA e detecta
  celular/relógio por cômodo para acionar luz/AC ao chegar.
- **Receptor IR permanente** (VS1838B): depois de capturar os aparelhos, fica fixo para usar
  qualquer controle remoto antigo como gatilho de cenas no HA (controle universal grátis).
- **LED RGB de status** (embutido): verde = AC ligado, vermelho = sem conexão, etc.
- **Botão BOOT** (embutido): um toque físico para uma ação rápida (ex.: "desligar tudo").

## Segredos e configs locais

- WiFi, chave de API e senha de OTA ficam em `esphome/.../secrets.yaml` (copiar de
  `esphome/secrets.yaml.example`) — **nunca** comitar valores reais.
- Calibração de toque e pinos podem variar por revisão do CYD — ajustar por dispositivo.
