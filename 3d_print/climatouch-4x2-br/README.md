# 3d_print/climatouch-4x2-br — case para caixa 4x2 brasileira

Local dos arquivos 3D do **case para espelho/caixa 4x2 BR** (em desenvolvimento). A
especificação completa, requisitos e abordagem de modelagem estão em
[../../docs/case-4x2-br.md](../../docs/case-4x2-br.md).

## Conteúdo (conforme evoluir)

```
3d_print/climatouch-4x2-br/
├── README.md                 (este arquivo)
├── ir-mod.scad               (OpenSCAD: importa o corpo herdado e fura janelas de IR) ✅
├── frontal-4x2.f3d           (fonte Fusion 360 — a criar)
├── frontal-4x2.stl           (impressão — a criar)
├── berco-placa.stl           (berço do CYD com recorte de tela e janela IR — a criar)
└── ASSEMBLY.md               (guia de montagem — a criar)
```

## `ir-mod.scad` — furos de IR no corpo herdado

Script OpenSCAD que **importa o `outer-body.stl` original e subtrai** os furos do emissor e do
receptor IR (+ ventilação do sensor). Abrir no OpenSCAD, ajustar os parâmetros (medir o CYD),
`Render` (F6) e `Export as STL`. Planejamento e parâmetros em
[../../docs/case-ir-mod.md](../../docs/case-ir-mod.md).

## Reaproveitamento

Partir dos arquivos-fonte herdados (`../ESP32-2432S028/*.f3d` / `.3mf`, em especial o
`inner-body` e o `flush-mount`) como base do berço, trocando a interface traseira da **caixa
europeia** pelas **orelhas de fixação da caixa 4x2 brasileira**.

> Enquanto não estiver pronto, usar as variantes **sob a mesa** e **mesa (ângulo ajustável)**
> já existentes em `../ESP32-2432S028/variants/`.
