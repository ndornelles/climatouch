# Roadmap

Fases do `climatouch`, do hardware até os painéis de parede.

## Fase 0 — Compras ✅ (em andamento)

- Componentes do exterior a caminho (placas, sensores, kit IR, passivos, jumpers).
- Fontes USB 5 V e cabos adquiridos no Brasil.

## Fase 1 — Protótipo (1 ponto)

- Montar **1 dispositivo** e validar a cadeia completa: tela + toque + WiFi + sensor + IR.
- Começar por um aparelho cujo protocolo já seja **nativo e confiável** no ESPHome — acelera a
  validação (o mapeamento específico fica nos arquivos locais, fora do repositório).
- Imprimir o case na variante **sob a mesa** ou **mesa (ângulo ajustável)** já existente.
- Critério de pronto: ligar/desligar e ajustar temperatura do AC pelo HA, 100% local, e ler
  temperatura/umidade/pressão na tela.

## Fase 2 — Réplica (demais pontos)

- Copiar a config trocando o **protocolo IR** por aparelho (ver matriz em
  [firmware.md](firmware.md)).
- Aparelhos sem protocolo nativo: **capturar** os códigos com o receptor IR e reproduzir.
- Padronizar `secrets.yaml` e nomes de entidade por cômodo.

## Fase 3 — WiFi-nativos (sem hardware)

- Ativar no Home Assistant os aparelhos que já têm WiFi via integração local
  (ex.: `midea_ac_lan`) e os de marca com integração própria.

## Fase 4 — Case 4x2 BR

- Desenvolver e validar o frontal para **caixa 4x2 brasileira** (ver
  [case-4x2-br.md](case-4x2-br.md)).
- Migrar os pontos que ficarão **embutidos na parede** (substituindo espelhos de tomada),
  prevendo alimentação 5 V atrás da parede.

## Fase 5 — Funcionalidades extras

- Ativar as features "grátis": tendência barométrica, auto-brilho (LDR), Bluetooth Proxy /
  presença BLE, receptor IR como controle universal, LED RGB de status, botão BOOT.

## Ideias futuras

- Câmeras IP de baixo custo via ESP32-CAM (projeto separado).
- Migrar switches/sensores para Zigbee para aliviar o WiFi (projeto separado).
