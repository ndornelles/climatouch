# climatouch

![ESPHome](https://img.shields.io/badge/ESPHome-Compatible-blue)
![Home Assistant](https://img.shields.io/badge/Home%20Assistant-Local-orange)
![Controle](https://img.shields.io/badge/Controle-100%25%20local-success)
![Licen%C3%A7a](https://img.shields.io/badge/Licen%C3%A7a-MIT-lightgrey)

> **Painel de toque ESP32 (Cheap Yellow Display + ESPHome) para controle 100% local de
> ar-condicionado por infravermelho e da casa pelo Home Assistant** — com sensor de
> temperatura/umidade/pressão e cases 3D pensados para o **padrão elétrico brasileiro
> (caixa 4x2)**, além de montagem sob a mesa e com ângulo ajustável.

Este projeto é um **fork adaptado** de
[akuehlewind/ESPHome-touch-display-mount](https://github.com/akuehlewind/ESPHome-touch-display-mount),
que entrega um excelente painel de toque (LVGL) + cases 3D para o Cheap Yellow Display.
O `climatouch` parte dessa base e acrescenta o que o projeto original não cobre:

| | Projeto original | climatouch (este fork) |
|---|---|---|
| Painel de toque HA (LVGL) | ✅ | ✅ (herdado) |
| Cases 3D (mesa / sob a mesa / parede / embutir) | ✅ | ✅ (herdado) |
| **Controle de ar-condicionado por IR** | ❌ | ✅ (emissor IR + `climate` ESPHome) |
| **Sensor de ambiente (temp/umidade/pressão)** | ❌ | ✅ |
| **Case para espelho/caixa 4x2 brasileira** | ❌ (só caixa europeia) | 🛠️ em desenvolvimento |
| **Receptor IR para aprender controles antigos** | ❌ | ✅ (opcional) |

## Por que existe

Os ar-condicionados eram controlados por um hub IR **dependente de nuvem**, que estourou a cota
de trial repetidas vezes e deixava os aparelhos sem resposta. O `climatouch` move esse controle
para **dentro de casa**: o ESP32 fala IR direto com o aparelho e WiFi local com o Home
Assistant — **sem nuvem, sem cota, sem trial**. Cada ponto vira também um painel de toque
para controlar luzes e cenas sem pegar o celular.

## Como funciona (resumo)

1. Um **Cheap Yellow Display (ESP32-2432S028R)** roda ESPHome com uma entidade `climate`.
2. Um **LED infravermelho** ligado a um GPIO emite os comandos para o ar-condicionado, usando
   os **protocolos de clima nativos do ESPHome** (ex.: `gree`, `coolix`, `daikin`…) ou códigos
   **capturados** com um receptor IR quando não há protocolo pronto.
3. Um **sensor AHT20+BMP280** mede temperatura, umidade e pressão do cômodo.
4. A tela exibe e ajusta o estado do AC e serve de **painel de controle do Home Assistant**.

## Documentação

| Documento | Conteúdo |
|---|---|
| [docs/hardware.md](docs/hardware.md) | Componentes (genérico), pinagem do CYD e ligações de IR e sensor |
| [docs/firmware.md](docs/firmware.md) | Estratégia ESPHome, matriz de protocolos IR por aparelho e funcionalidades grátis |
| [docs/case-4x2-br.md](docs/case-4x2-br.md) | Especificação do case para espelho 4x2 BR + variantes herdadas |
| [docs/roadmap.md](docs/roadmap.md) | Fases do projeto (compras → protótipo → réplica → parede) |
| [docs/UPSTREAM.md](docs/UPSTREAM.md) | README original do projeto-base (preservado) |

## Status

🛠️ **Em desenvolvimento** — fase de compras/prototipagem. As configs ESPHome específicas e os
STLs do case 4x2 BR entram conforme o hardware é montado e validado. Acompanhe o
[roadmap](docs/roadmap.md).

## Créditos e licença

Baseado em [akuehlewind/ESPHome-touch-display-mount](https://github.com/akuehlewind/ESPHome-touch-display-mount)
(LVGL UI + cases 3D), licenciado sob **MIT**. Este fork mantém a mesma licença MIT — veja
[LICENSE](LICENSE) e [NOTICE.md](NOTICE.md). Os arquivos 3D e configs herdados continuam sob os
créditos originais; as adições do `climatouch` (controle IR, sensor, case 4x2 BR) seguem a
mesma licença.
