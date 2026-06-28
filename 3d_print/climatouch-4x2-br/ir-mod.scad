// =============================================================================
// ir-mod.scad — adiciona furos de IR (emissor + receptor) ao case do climatouch
//
// Importa o corpo original do case (do projeto-base) e SUBTRAI a geometria dos
// furos do LED IR emissor e do receptor VS1838B. Edição reproduzível e
// versionável — não mexe na malha à mão.
//
// USO:
//   1) Abrir no OpenSCAD.
//   2) Ajustar os parâmetros abaixo (medir o CYD/STL; usar PREVIEW + '#' p/ alinhar).
//   3) Render (F6) -> Export as STL.
//
// ATENÇÃO: todas as posições/ângulos são PLACEHOLDERS até medir o hardware real.
// Ver ../../docs/case-ir-mod.md.
// =============================================================================

// ---- Corpo original a furar (caminho relativo a este arquivo) ----
// Troque para a variante desejada (outer-body padrão, wide, etc.).
body_stl = "../ESP32-2432S028/outer-body.stl";

// ---- Diâmetros dos furos (mm) — folga de ~0.2mm já incluída ----
emitter_d   = 5.2;   // LED IR 5mm  (use 3.2 para LED de 3mm)
receiver_d  = 5.2;   // receptor VS1838B (cabeça ~5mm)

// ---- Profundidade do corte (atravessa a parede com folga) ----
cut_len     = 30;    // comprimento do cilindro de corte (>= espessura da parede)

// ---- Posições dos furos no referencial do STL importado (MEDIR!) ----
// Dica: rode em preview, descomente os '#' lá embaixo p/ ver os cilindros
// e mova até atravessarem a moldura, FORA da area de toque.
emitter_pos  = [ -8, -28, 0 ];   // [x, y, z]
receiver_pos = [  8, -28, 0 ];

// ---- Ângulos (graus) — só se o frontal nao apontar direto p/ o AR ----
emitter_tilt  = [0, 0, 0];   // ex.: [15,0,0] inclina o furo do emissor
receiver_tilt = [0, 0, 0];

// ---- Ventilação do sensor AHT20 (grade de furinhos) ----
vent_enable  = true;
vent_pos     = [ 0, 28, 0 ];  // moldura oposta aos furos de IR (MEDIR)
vent_d       = 1.6;            // furo fino
vent_cols    = 4;
vent_rows    = 3;
vent_pitch   = 3.2;           // espacamento entre furos

$fn = 48;

module ir_hole(pos, tilt, d) {
    translate(pos) rotate(tilt)
        cylinder(h = cut_len, d = d, center = true);
}

module vent_grid(pos, d, cols, rows, pitch) {
    translate(pos)
    for (i = [0:cols-1], j = [0:rows-1])
        translate([ (i-(cols-1)/2)*pitch, (j-(rows-1)/2)*pitch, 0 ])
            cylinder(h = cut_len, d = d, center = true);
}

difference() {
    import(body_stl, convexity = 10);
    ir_hole(emitter_pos,  emitter_tilt,  emitter_d);
    ir_hole(receiver_pos, receiver_tilt, receiver_d);
    if (vent_enable)
        vent_grid(vent_pos, vent_d, vent_cols, vent_rows, vent_pitch);
}

// --- Alinhamento (descomente p/ enxergar os cortes sobre o corpo em preview) ---
// #ir_hole(emitter_pos,  emitter_tilt,  emitter_d);
// #ir_hole(receiver_pos, receiver_tilt, receiver_d);
// if (vent_enable) #vent_grid(vent_pos, vent_d, vent_cols, vent_rows, vent_pitch);
