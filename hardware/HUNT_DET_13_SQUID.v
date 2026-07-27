timescale 1ns / 1ps
// =========================================================================
// REPOSITORIO: HUNT-TCU-V12-PEUO-CORE - ARCHIVO 13
// Módulo: HUNT_DET_13_SQUID.v
// Propósito: Unidad de digitalización por rotación Faraday pasiva
// =========================================================================

module HUNT_DET_13_SQUID (
    input  wire        clk_optical,       // Reloj óptico de lectura
    input  wire        rst_n,
    input  wire [15:0] measured_deflection, // Ángulo de deflexión fotónica molecular
    output reg  [15:0] bus_data_out,      // Flujo digital directo de salida
    output reg         read_valid         // Bandera de validez de lectura sutil
);

    // Ventanas de tolerancia angular según el Teorema de Hunt
    localparam [15:0] THRESHOLD_MIN = 16'd10;
    localparam [15:0] THRESHOLD_MAX = 16'd35;

    always @(posedge clk_optical or negedge rst_n) begin
        if (!rst_n) begin
            bus_data_out <= 16'b0;
            read_valid   <= 1'b0;
        end else begin
            // Evaluación pasiva del haz óptico en microvatios
            if ((measured_deflection >= THRESHOLD_MIN) && (measured_deflection <= THRESHOLD_MAX)) begin
                bus_data_out <= measured_deflection << 2; // Decodificación limpia
                read_valid   <= 1'b1;
            end else begin
                bus_data_out <= 16'hFFFF; // Dispersión caótica fuera de rango
                read_valid   <= 1'b0;
            end
        end
    end

endmodule
