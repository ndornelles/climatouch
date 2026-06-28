# esphome/climatouch — config base do projeto

Esta pasta abriga as configurações ESPHome **específicas do climatouch** (controle de AC por IR
+ sensor de ambiente), que se somam à UI herdada em `esphome/home-like/` e `esphome/buttons/`.

## Plano de arquivos (entram na Fase 1, com o hardware em mãos)

```
esphome/climatouch/
├── README.md              (este arquivo)
├── secrets.yaml.example   (modelo — copiar para secrets.yaml, NÃO comitar o real)
├── common/
│   ├── base.yaml          (wifi, api, ota, sensor I2C, LDR, RGB, BOOT — comum a todos)
│   └── ir.yaml            (remote_transmitter/receiver + entidade climate)
└── devices/
    └── <comodo>.yaml      (1 arquivo por ponto: inclui common + define protocolo/pinos/room)
```

> Os YAMLs reais entram quando o primeiro dispositivo for montado e validado (ver
> [../../docs/roadmap.md](../../docs/roadmap.md)). Os esqueletos de `climate` (nativo) e de
> captura IR estão em [../../docs/firmware.md](../../docs/firmware.md).

## Regras

- **Nunca** comitar `secrets.yaml`, chaves de API, senhas de OTA, tokens do HA, IPs internos
  ou códigos IR capturados de uma residência específica.
- Pinos e calibração de toque podem variar por revisão do CYD — ajustar por dispositivo.
- Reaproveitar ao máximo a UI do upstream; o climatouch só adiciona a camada de clima/sensor.
