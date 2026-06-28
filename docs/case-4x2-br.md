# Case — espelho/caixa 4x2 brasileira + variantes herdadas

> A grande adição do `climatouch` no lado mecânico: um case para o **padrão elétrico
> brasileiro** (caixa de embutir **4x2**), que o projeto original não cobre (lá o "flush mount"
> é para caixa **europeia**). Também precisa acomodar o **emissor IR** e o **sensor**, que o
> case original não previa.

## Variantes herdadas (já no repositório)

Em `3d_print/ESP32-2432S028/` (para o CYD) e `3d_print/ILI9341-only-display/`:

| Variante | Arquivo | Serve para |
|---|---|---|
| Mesa (ângulo ajustável ±35°) | `variants/desk-mount/desk-mount.stl` | bancada, mesa de trabalho |
| **Sob a mesa** | `variants/under-desk-mount/under-desk-mount.stl` | embaixo de mesa/prateleira |
| Parede | `variants/wall-mount/wall-mount-touch-display.stl` | superfície de parede |
| Embutir (caixa **EU**) | `variants/flush-mount/flush-mount-body.stl` | caixa europeia — **não** é 4x2 BR |

Corpo comum (todas as variantes): `inner-body.stl`, `outer-body.stl`, `locking-body.stl`.
Montagem em `3d_print/ESP32-2432S028/ASSEMBLY.md`. Os dois mounts que o Nickolas quer —
**sob a mesa** e **ângulo ajustável** — já existem e podem ser impressos de imediato para o
protótipo, antes do case 4x2 ficar pronto.

## O que vamos desenvolver (`3d_print/climatouch-4x2-br/`)

Objetivo: substituir o espelho/tampa de uma **caixa 4x2** (embutida na parede) por um frontal
que segura o CYD, com a tela rente à parede.

### Requisitos

1. **Encaixe na caixa 4x2 padrão BR** — furação nos centros de fixação da caixa 4x2
   (distância entre orelhas conforme norma BR), aceitando os parafusos da própria caixa.
2. **Recorte da tela** alinhado à área visível do ILI9341 (2.8"), com a placa recuada para
   caber na profundidade da caixa.
3. **Janela / canal para o LED IR** — o emissor precisa de linha de visada para o aparelho;
   prever um furo discreto no frontal ou saída lateral. (Em parede, avaliar se o ângulo até o
   AC é viável; senão, usar a variante de mesa/sob a mesa onde a mira é melhor.)
4. **Passagem de ar para o sensor** — pequenas aberturas para o AHT20 ler temperatura/umidade
   reais do ambiente, sem o calor da própria placa contaminar a leitura (afastar o sensor da
   placa / ventilar).
5. **Entrada de cabo 5 V** por trás (vindo da caixa) — sem conector aparente na frente.
6. **Acabamento** combinando com espelhos de tomada comuns (cantos, espessura do frontal).

### Abordagem de modelagem

- Partir dos arquivos-fonte Fusion 360 herdados (`.f3d`/`.3mf`) do `inner-body`/`flush-mount`
  como base do berço da placa, e **trocar a interface traseira** (caixa EU → orelhas 4x2 BR).
- Validar medidas com uma caixa 4x2 real e o CYD em mãos antes de imprimir a versão final.
- Imprimir em PETG (mais resistente ao calor perto do AC/parede) — filamento e impressão a
  definir (impressora própria vs. serviço).

### Entregáveis (conforme evoluir)

- [ ] Rascunho de medidas (caixa 4x2 + footprint do CYD)
- [ ] Modelo do frontal 4x2 (`.f3d` fonte + `.stl` para impressão)
- [ ] Berço da placa com recorte da tela e janela do IR
- [ ] Teste de encaixe impresso e ajuste de tolerâncias
- [ ] Guia de montagem (análogo ao `ASSEMBLY.md` herdado)

> Enquanto o case 4x2 não fica pronto, o protótipo roda nas variantes **mesa** / **sob a mesa**
> já existentes.
