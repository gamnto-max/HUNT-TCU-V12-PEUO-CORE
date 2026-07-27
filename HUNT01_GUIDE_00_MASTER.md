# HUNT_GUIDE_00_MASTER.md
> **Ecosistema:** HUNT-TCU-V12-PEUO-CORE  
> **Nivel:** Directriz Maestra de Orquestación e Indexación  
> **Propósito:** Secuenciación estricta de compilación y dependencias lógicas  

Este documento coordina la inicialización secuencial del procesador cuántico de matriz de espín. Para garantizar que las herramientas de síntesis avanzada (Synopsys, Cadence) y simulación lógica mapeen correctamente las dependencias atómicas sin errores de desalineación, los ingenieros deben seguir el orden indexado establecido.

---

## 🗺️ Mapa de Ruta e Indexación de Archivos

### ⚡ Fase 1: Dimensión Material (Hardware RTL - Verilog)
El hardware debe compilarse en el orden exacto de su índice para que las primitivas de acoplamiento de espín se registren antes de las unidades lógicas y aritméticas superiores:

1. **`hardware/HUNT_CORE_01_SPIN.v`**
   * *Descripción:* Núcleo RTL base. Mapea la superposición de los espines electrónicos sobre el sustrato puro de Silicio-28.
   * *Dependencias:* Ninguna (Celda elemental).
2. **`hardware/HUNT_GATE_06_SPIN.v`**
   * *Descripción:* Bloque de compuertas cuánticas por correlación y coincidencia armónica de fase. Reemplaza la lógica CMOS clásica.
   * *Dependencias:* `HUNT_CORE_01_SPIN.v`.
3. **`hardware/HUNT_TIME_07_ATTO.v`**
   * *Descripción:* Reloj y controlador temporal cuántico de ventana. Valida que las transiciones ocurran en la escala de attosegundos sin retardos RC.
   * *Dependencias:* `HUNT_GATE_06_SPIN.v`.
4. **`hardware/HUNT_CORE_12_ALU.v`**
   * *Descripción:* Unidad Aritmética de Espín (SAU). Pipeline matricial encargado de resolver las interferencias ondulatorias lógicas del PEUO.
   * *Dependencias:* `HUNT_TIME_07_ATTO.v`.
5. **`hardware/HUNT_DET_13_SQUID.v`**
   * *Descripción:* Unidad de digitalización y detección óptica final. Traduce la rotación Faraday en el bus óptico de salida.
   * *Dependencias:* `HUNT_CORE_12_ALU.v`.

### 🔌 Fase 2: Dimensión Termal y de Arranque (Firmware - C++)
Una vez sintetizada la red lógica del silicio, se requiere el firmware nativo para estabilizar las condiciones físicas del cristal:

6. **`firmware/HUNT_FW_10_INIT.cpp`**
   * *Descripción:* Código embebido de bajo nivel para estaciones ATE. Inyecta el pulso de bombeo óptico a 90° (ortogonal) para la alineación inicial de los espines.
   * *Dependencias:* Inicialización física completa de la oblea procesada.

### 🕹️ Fase 3: Dimensión de Control y Validación (Software - Python)
Scripts de automatización en fundición y plataformas virtuales unificadas para el usuario final:

7. **`software/hunt_foundry_orchestrator.py`**
   * *Descripción:* script de telemetría automatizada para control de calidad de las obleas de Silicio-28 en las plantas de TSMC/IBM.
   * *Dependencias:* Entorno Python estándar.
8. **`software/streamlit_app.py`**
   * *Descripción:* Interfaz gráfica plana unificada y optimizada específicamente para el entorno en la nube de `create.streamlit.app`.
   * *Dependencias:* Resolución automática de librerías nativas por la plataforma Streamlit.

### 📜 Fase 4: Especificaciones de Manufactura (Documentación - Markdown)
9. **`docs/HUNT_PKG_09_SHIELD.md`**
   * *Descripción:* Requisitos de encapsulado industrial avanzados. Define los parámetros de la jaula de grafeno, aislamiento magnético por Mu-Metal y el sellado de vacío cuántico a 10⁻⁷ Torr.

---

## 🔒 Matriz de Dependencias Cruzadas del PEUO

```text
[Sustrato Si-28 Pureza 99.999%]
       │
       ▼
[HUNT_CORE_01_SPIN] ──► Regido por la ausencia de espín nuclear (Si-29 = 0)
       │
       ▼
[HUNT_GATE_06_SPIN] ──► Acoplamiento cuántico por interferencia constructiva
       │
       ▼
[HUNT_TIME_07_ATTO] ──► Validación de velocidad límite (RC = 0) sin pérdidas Joule
       │
       ▼
[HUNT_CORE_12_ALU]  ──► Operaciones matemáticas instantáneas en el cristal
       │
       ▼
[HUNT_DET_13_SQUID] ──► Detección por dispersión Faraday pasiva en microvatios (µW)
```

---

## 🛠️ Instrucciones de Integridad para Ingenieros de NVIDIA / AMD

* **Síntesis Estricta:** Las herramientas de fotolitografía deben compilar el pipeline siguiendo los índices `01 -> 06 -> 07 -> 12 -> 13`. Cualquier alteración en el árbol de dependencias romperá el sincronismo de los pulsos del láser de zafiro.
* **Verificación de Aserciones:** El script `hunt_foundry_orchestrator.py` debe arrojar un índice de conformidad del 100% en la pureza del material antes de autorizar la carga del firmware nativo `HUNT_FW_10_INIT.cpp`.
  
