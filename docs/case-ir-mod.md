# Modificação do case para infravermelho (emissor + receptor)

> O case do projeto-base foi desenhado para um painel de toque **puro** — não previa IR. Para o
> climatouch, o gabinete precisa acomodar o **emissor IR** (controlar o ar-condicionado) e o
> **receptor IR** (capturar códigos / usar como controle universal), além do driver e do sensor.
> Este documento planeja essa modificação e descreve como aplicá-la de forma **reproduzível**
> (sem "editar o STL na mão").

## O que precisa caber, além do que já cabia

| Componente | Necessidade no case |
|---|---|
| **LED IR emissor (940 nm)** | furo na face frontal com **linha de visada** para o aparelho |
| **Receptor IR (VS1838B)** | furo na face frontal voltado para o cômodo (enxergar controles) |
| **Driver (transistor 2N2222 + resistores)** | pequeno volume interno / mini-perfboard atrás da placa |
| **Sensor AHT20 (já previsto)** | aberturas de ventilação afastadas do calor da placa |

## Desafios específicos do IR (decisões de projeto)

1. **IR não atravessa plástico opaco.** PETG/PLA comum bloqueia 940 nm. → **Furos passantes**:
   o LED e o receptor ficam rentes à face externa (ou levemente salientes), não atrás de parede
   cheia. (Opção futura: janela em filamento translúcido, mas furo passante é mais simples e
   confiável.)
2. **Linha de visada do emissor.** Em case de **mesa / sob a mesa**, o LED aponta para frente e
   acerta o AC facilmente. Em case **de parede / 4x2**, o frontal aponta para o cômodo — se o AC
   não estiver nessa direção, prever **saída superior/lateral** ou um furo levemente **angulado**.
   Por isso o parâmetro de ângulo no script.
3. **Não atrapalhar o toque.** Furos na **moldura** (borda inferior/superior), fora da área ativa
   da tela.
4. **Folga interna.** O gabinete original é justo. O driver (transistor + 1–2 resistores) vai numa
   **mini-perfboard** atrás da placa; se não couber, aumentar a profundidade do `inner-body`/
   `outer-body` (parâmetro no Fusion) em alguns mm.
5. **Reaproveitar a montagem.** Manter o encaixe (snap-fit) e os mounts herdados; a modificação é
   **aditiva** (furos + ventilação), sem reprojetar o corpo.

## Como aplicar a modificação (reproduzível, versionável)

Duas vias — a primeira é a que mantemos no repositório:

### Via A — OpenSCAD (no repo)
O arquivo [`../3d_print/climatouch-4x2-br/ir-mod.scad`](../3d_print/climatouch-4x2-br/ir-mod.scad)
**importa o STL do corpo original** e **subtrai** (`difference()`) os cilindros dos furos de IR.
É texto (versionável no git), parametrizado e reproduzível:

1. Abrir o `.scad` no OpenSCAD.
2. Ajustar os parâmetros (posições/diâmetros) — ver "Parâmetros a confirmar".
3. `Render` (F6) → `Export as STL`. Pronto: STL modificado, sem editar malha à mão.

### Via B — Fusion 360 (fonte paramétrica)
Editar o `.f3d` herdado (em `3d_print/ESP32-2432S028/`) diretamente — adicionar os furos e a
ventilação no histórico paramétrico. Melhor para o **case 4x2 BR**, que já exige trocar a
interface traseira (ver [case-4x2-br.md](case-4x2-br.md)).

## Parâmetros a confirmar (com o CYD em mãos)

Sem o hardware e as medidas reais, posições são **placeholders**. Confirmar:

- [ ] Dimensões reais do `outer-body` e **orientação** do STL ao importar (usar `#` no OpenSCAD
      para destacar e alinhar os furos).
- [ ] Diâmetro do LED IR (3 mm ou 5 mm) e do VS1838B (~5 mm) → `emitter_d` / `receiver_d`.
- [ ] Posição (x,y) dos furos na moldura, fora da área de toque → `emitter_pos` / `receiver_pos`.
- [ ] Ângulo do emissor, se o frontal não apontar para o AR → `emitter_tilt`.
- [ ] Espaço interno para o driver; decidir mini-perfboard vs. aumentar profundidade.

## Sequência sugerida

1. Montar o protótipo em **protoboard** e achar a posição/alcance reais do LED e do receptor.
2. Medir o `outer-body` impresso + o CYD.
3. Preencher os parâmetros no `ir-mod.scad`, gerar o STL, imprimir e testar o encaixe dos furos.
4. Consolidar no case **4x2 BR** (Via B no Fusion) junto com a interface traseira.
