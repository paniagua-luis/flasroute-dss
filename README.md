# 🚛 DSS FlashRoute — Sistema Inteligente de Gestión Logística

> **Actividad 2 — Formulación del MVP: "De la Raíz a la Solución"**  
> Materia: Sistemas de Información II | Caso: FlashLogistics  
> Gestión: 2026 | Universidad Privada Domingo Savio 

---

## 👥 Integrantes del Squad

| Nombre completo | Código | Rol en el equipo |
|---|---|---|
| [Eiber Fabian Yurquina Mendoza ] | [CÓD-001] | Product Owner / Análisis |
| [Arnaldo Manuel Cardozo Artunduaga] | [CÓD-002] | Tech Lead / Backend |
| [Luis Manuel Paniagua Barrios ] | [CÓD-003] | Frontend / UX |
| [Roberto Niver Pimentel Erazo] | [CÓD-004] | QA / Documentación |

---

## 📋 Tabla de Contenidos

1. [El Problema](#-el-problema-flashlogistics)
2. [Árbol de Problemas](#-árbol-de-problemas)
3. [Árbol de Soluciones](#-árbol-de-soluciones)
4. [Objetivo SMART](#-objetivo-smart)
5. [Visión del Producto](#-visión-del-producto)
6. [Es / No Es / Hace / No Hace](#-es--no-es--hace--no-hace)
7. [Personas](#-personas)
8. [User Journey](#-user-journey)
9. [Canvas MVP](#-canvas-mvp)
10. [Tecnologías](#-tecnologías-propuestas)
11. [Cronograma](#-cronograma-por-sprints)
12. [ODS](#-alineación-con-los-ods)

---

## 🔥 El Problema: FlashLogistics

**FlashLogistics** es una empresa de distribución de productos de consumo masivo que atraviesa una crisis operativa crítica:

| Indicador | Situación actual | Meta con el sistema |
|---|---|---|
| Entregas tardías | **30%** de los pedidos | < 5% |
| Costo combustible | **+15%** en 6 meses | Reducción del 10% |
| Tiempo de planificación | **4 horas/día** manuales | < 30 minutos |
| Llamadas de seguimiento | **50+ llamadas/día** | Reducción del 80% |
| Visibilidad de flota | **0%** — sin rastreo | 100% en tiempo real |

---

## 🌳 Árbol de Problemas

```
┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
│  Pérdida de utilidad    │  │ Disminución participación│  │ Pérdida de motivación   │  │ Imposibilidad de        │
│  y rentabilidad         │  │ de mercado               │  │ de la mano de obra      │  │ escalar el negocio      │
└───────────┬─────────────┘  └───────────┬──────────────┘  └───────────┬─────────────┘  └───────────┬─────────────┘
            │                            │                              │                             │
            └────────────────────────────┴──────────────────────────────┴─────────────────────────────┘
                                                         │
┌────────────────────────┐  ┌──────────────────────────┐│┌──────────────────────────┐  ┌──────────────────────────┐
│ 30% de entregas        │  │ Cancelación de contratos ││││ Sobrecarga de            │  │ Costos de combustible    │
│ tardías                │  │ por clientes             ││││ despachadores (4h/día)   │  │ +15% sin control         │
└────────────────────────┘  └──────────────────────────┘│└──────────────────────────┘  └──────────────────────────┘
                                                         │
                    ╔════════════════════════════════════╧════════════════════════════════════╗
                    ║                                                                         ║
                    ║     PROBLEMA CENTRAL: Crisis operativa en FlashLogistics —              ║
                    ║     ineficiencia en la gestión y distribución logística                 ║
                    ║                                                                         ║
                    ╚════════════════════════════════════╤════════════════════════════════════╝
                                                         │
┌────────────────────────┐  ┌──────────────────────────┐│┌──────────────────────────┐  ┌──────────────────────────┐
│ Planificación manual   │  │ Sin rastreo en tiempo    ││││ Sin datos de eficiencia  │  │ Sin sistema de info      │
│ de rutas (pizarra)     │  │ real de vehículos        ││││ de conductores ni rutas  │  │ para clientes            │
└────────────┬───────────┘  └────────────┬─────────────┘│└────────────┬─────────────┘  └────────────┬─────────────┘
             │                           │               │             │                              │
┌────────────┴───────────┐  ┌────────────┴─────────────┐ ┌────────────┴─────────────┐  ┌────────────┴─────────────┐
│ Ausencia de software   │  │ Falta de dispositivos    │ │ No hay sistema de BI     │  │ Ausencia de portal de    │
│ de optimización        │  │ GPS en la flota          │ │ ni KPIs operativos       │  │ notificaciones           │
└────────────────────────┘  └──────────────────────────┘ └──────────────────────────┘  └──────────────────────────┘
                                            ▲ CAUSAS RAÍZ
```

---

## 🌱 Árbol de Soluciones

```
┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
│ Aumento de rentabilidad │  │ Incremento de           │  │ Personal motivado y     │  │ Empresa escalable y     │
│ y reducción de costos   │  │ participación mercado   │  │ productivo              │  │ competitiva             │
└─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
│ Entregas a tiempo       │  │ Clientes satisfechos    │  │ Despachadores libres de │  │ Combustible optimizado  │
│ (meta: < 5% tardías)    │  │ y fidelizados           │  │ tareas repetitivas      │  │ (-10% de costos)        │
└─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
                    ╔════════════════════════════════════════════════════════════════════════╗
                    ║                                                                        ║
                    ║    SOLUCIÓN CENTRAL: DSS FlashRoute — Sistema inteligente de          ║
                    ║    gestión y optimización logística para FlashLogistics               ║
                    ║                                                                        ║
                    ╚════════════════════════════════════════════════════════════════════════╝
┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
│ Módulo de Optimización  │  │ Módulo de Rastreo GPS   │  │ Módulo de BI y          │  │ Portal de Seguimiento   │
│ de Rutas automático     │  │ en Tiempo Real          │  │ Dashboard de KPIs       │  │ de Pedidos (clientes)   │
└─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
│ Automatización de       │  │ Integración GPS +       │  │ Registro automático de  │  │ Notificaciones auto     │
│ planificación diaria    │  │ notificaciones a choferes│ │ KPIs y reportes         │  │ por WhatsApp/SMS        │
└─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘  └─────────────────────────┘
                                            ▲ MÓDULOS / ACCIONES
```

---

## 🎯 Objetivo SMART

> **"Desarrollar e implementar el DSS FlashRoute que reduzca las entregas tardías del 30% al 10%, el tiempo de planificación de rutas de 4 horas a menos de 30 minutos, y las llamadas de seguimiento en un 80%, mediante un sistema web de optimización de rutas, rastreo GPS y notificaciones automáticas, en un plazo de 3 meses con 4 sprints de desarrollo."**

| Dimensión | Detalle |
|---|---|
| **S — Específico** | DSS web que automatiza rutas, provee rastreo GPS en tiempo real y notifica a clientes |
| **M — Medible** | Entregas tardías: 30% → 10% · Planificación: 4h → <30min · Llamadas: -80% |
| **A — Alcanzable** | MVP de 5 funcionalidades core, equipo de 4 devs, tecnologías disponibles (React / Node / PostgreSQL) |
| **R — Relevante** | Ataca directamente la crisis operativa; alineado con ODS 8 y ODS 9 |
| **T — Temporal** | MVP en producción en **3 meses** (4 sprints de 2 semanas) |

---

## 💡 Visión del Producto

> **Para** FlashLogistics, una empresa de distribución que sufre ineficiencia operativa y pérdida de clientes,  
> **que tiene el problema** de no poder gestionar su flota en tiempo real ni planificar rutas de forma eficiente,  
> **el DSS FlashRoute es** un sistema de apoyo a la toma de decisiones logísticas,  
> **que ofrece** optimización automática de rutas, visibilidad total de la flota y comunicación proactiva con clientes,  
> **a diferencia de** las hojas de Excel y la pizarra blanca actuales,  
> **nuestro producto** transforma el caos operativo en inteligencia logística accionable, permitiendo que FlashLogistics recupere la confianza de sus clientes y escale su negocio.

---

## 🔲 Es / No Es / Hace / No Hace

| ✅ **ES** | ❌ **NO ES** |
|---|---|
| Un DSS (Sistema de Apoyo a Decisiones) logístico | Un sistema de contabilidad o facturación |
| Un optimizador de rutas basado en datos en tiempo real | Un ERP completo |
| Una plataforma de visibilidad de flota | Una app de mantenimiento mecánico |
| Un sistema de notificaciones automáticas a clientes | Una red social para conductores |

| ✅ **HACE** | ❌ **NO HACE** |
|---|---|
| Calcula y asigna rutas óptimas automáticamente | No repara vehículos ni gestiona inventarios |
| Muestra la ubicación GPS de cada camión en tiempo real | No procesa pagos ni facturas |
| Notifica a clientes por WhatsApp/SMS | No gestiona nóminas de conductores |
| Genera reportes y dashboard de KPIs operativos | No opera sin conexión a internet (v1.0) |

---

## 👤 Personas

### Persona 1 — Carlos Mendoza · Gerente de Operaciones
> *"No puedo gestionar lo que no puedo ver."*

- **Comportamiento:** Llega antes que todos para planificar el día en una pizarra. Toma decisiones bajo presión constante. Frustrado por la falta de visibilidad.
- **Necesidades:** Dashboard con toda la flota en un mapa · Alertas automáticas de retrasos · Reportes sin trabajo manual.

---

### Persona 2 — Ana Torres · Despachadora Senior
> *"Atiendo las mismas 3 preguntas todo el día."*

- **Comportamiento:** Pasa 4h/día atendiendo llamadas repetitivas de clientes. Usa Excel + WhatsApp como sus "sistemas". Está agotada y no puede planificar.
- **Necesidades:** Notificaciones automáticas a clientes · Acceso rápido al estado de cualquier pedido · Menos interrupciones.

---

### Persona 3 — Pedro Quispe · Conductor de Reparto
> *"A veces no sé qué hacer cuando hay un desvío."*

- **Comportamiento:** Recibe su ruta verbal o en papel. Usa Google Maps propio. Llama a despacho si surge un imprevisto.
- **Necesidades:** Ruta optimizada en su celular · Reportar novedades sin llamar · Confirmación digital de entregas.

---

### Persona 4 — Cliente B2B (Empresa Retail)
> *"Si no sé dónde está mi pedido, busco otro proveedor."*

- **Comportamiento:** Compra grandes volúmenes. Exige puntualidad para sus líneas de producción. Ha amenazado con cambiar de proveedor.
- **Necesidades:** Seguimiento en tiempo real del pedido · Notificación al momento del despacho · No tener que llamar.

---

## 🗺️ User Journey

### ❌ Recorrido ACTUAL (sin sistema)

**Gerente de Operaciones:**
1. Llega a las 6am → dibuja rutas en pizarra blanca
2. Copia las rutas manualmente a Excel
3. Llama a conductores uno por uno para asignar rutas
4. Recibe llamadas de clientes preguntando por sus pedidos
5. No sabe dónde están los camiones durante el día
6. Al final del día, no tiene datos de eficiencia ni reportes

**Despachadora:**
1. Recibe 50+ llamadas de clientes preguntando "¿dónde está mi pedido?"
2. Llama a conductores para preguntar su posición
3. Comunica manualmente la info al cliente
4. Repite esto durante 4 horas sin poder hacer otro trabajo

---

### ✅ Recorrido IDEAL (con DSS FlashRoute)

**Gerente de Operaciones:**
1. Ingresa al DSS desde su PC ← el sistema ya calculó las rutas óptimas
2. Revisa y aprueba rutas con **1 clic** → sistema notifica automáticamente a conductores
3. Monitorea el **mapa en tiempo real** con la flota completa
4. Recibe alertas automáticas solo cuando hay una excepción real
5. Al final del día, descarga el **reporte de KPIs en PDF** en 2 minutos

**Despachadora:**
1. Cliente llama → consulta el estado del pedido en **5 segundos** desde el sistema
2. El portal ya **notificó automáticamente** al cliente en el momento del despacho
3. Solo atiende excepciones reales (accidentes, retrasos mayores)
4. Libera **3+ horas diarias** para tareas de planificación y valor

---

## 📦 Canvas MVP

| Sección | Detalle |
|---|---|
| **🎯 Propuesta del MVP** | DSS FlashRoute v1.0: plataforma web que automatiza la planificación de rutas, provee rastreo GPS en tiempo real y notifica a los clientes el estado de sus pedidos. Ataca las 3 causas raíz de mayor impacto. |
| **👥 Personas atendidas** | Gerente de Operaciones · Despachadora · Conductor de Reparto · Cliente B2B |
| **🗺️ Viajes atendidos** | Planificación diaria de rutas (pizarra → automático en <15 min) · Seguimiento de flota en tránsito · Atención de consultas de clientes (portal self-service 24/7) |
| **⚙️ Funcionalidades MVP** | 1. Optimizador automático de rutas · 2. Mapa GPS en tiempo real · 3. Notificaciones automáticas al cliente (WhatsApp/SMS) · 4. Dashboard de KPIs operativos · 5. Portal self-service para clientes |
| **📊 Resultado esperado** | Reducir entregas tardías del **30% → 10%** · Planificación: 4h → **<30 min** · Llamadas de seguimiento: **-80%** · Todo medible en el dashboard del sistema |
| **🗓️ Cronograma** | Sprint 1 (sem 1-2): Backend + BD + API GPS · Sprint 2 (sem 3-4): Algoritmo de rutas + mapa · Sprint 3 (sem 5-6): Notificaciones + portal cliente · Sprint 4 (sem 7-8): Dashboard KPIs + UAT + deploy |

---

## 🛠️ Tecnologías Propuestas

| Capa | Tecnología |
|---|---|
| **Frontend** | React.js + Tailwind CSS + Leaflet.js (mapas) |
| **Backend** | Node.js + Express |
| **Base de datos** | PostgreSQL |
| **GPS / Maps** | Google Maps API / OpenStreetMap |
| **Notificaciones** | Twilio (WhatsApp + SMS) |
| **Autenticación** | JWT |
| **Deploy** | Railway / Render (MVP) |

---

## 🗓️ Cronograma por Sprints

```
Sprint 1 ████████░░░░░░░░░░░░░░░░  Sem 1–2  Backend + Base de datos + Integración GPS
Sprint 2 ████████████████░░░░░░░░  Sem 3–4  Algoritmo de rutas + Mapa frontend
Sprint 3 ████████████████████████  Sem 5–6  Notificaciones + Portal cliente
Sprint 4 ████████████████████████  Sem 7–8  Dashboard KPIs + Pruebas UAT + Deploy
```

| Sprint | Semanas | Entregable principal |
|---|---|---|
| Sprint 1 | 1 – 2 | Backend funcional + API GPS conectada + BD |
| Sprint 2 | 3 – 4 | Módulo de rutas + Mapa con flota en tiempo real |
| Sprint 3 | 5 – 6 | Notificaciones automáticas + Portal self-service cliente |
| Sprint 4 | 7 – 8 | Dashboard KPIs + Pruebas UAT + Despliegue en producción |

---

## 🌍 Alineación con los ODS

### ODS 8 — Trabajo Decente y Crecimiento Económico
DSS FlashRoute elimina la fatiga cognitiva del personal operativo al automatizar tareas repetitivas. Los despachadores recuperan 3+ horas diarias; los conductores trabajan con información clara. Esto mejora directamente las condiciones laborales y permite el crecimiento económico sostenible de la empresa.

### ODS 9 — Industria, Innovación e Infraestructura
El sistema digitaliza y moderniza la infraestructura logística de una PYME mediante tecnología accesible (APIs, algoritmos de optimización, analítica de datos), democratizando herramientas DSS que antes solo estaban al alcance de grandes corporaciones.

---

## 📁 Estructura del Repositorio

```
flashroute-dss/
├── README.md                    ← Este archivo (Canvas MVP + visión)
├── docs/
│   ├── Actividad2_MVP.pdf       ← Entregable PDF final
│   ├── arbol_problemas.png      ← Árbol de problemas
│   └── arbol_soluciones.png     ← Árbol de soluciones
├── src/
│   ├── backend/                 ← API Node.js + Express
│   └── frontend/                ← React.js
└── .github/
    └── workflows/               ← CI/CD (Sprint 4)
```

---

## 📌 Tablero Kanban

El progreso del proyecto se gestiona en **GitHub Projects** → [Ver tablero aquí](../../projects)

| Columna | Descripción |
|---|---|
| 📋 Backlog | Funcionalidades identificadas pendientes de sprint |
| 🔄 En progreso | Tareas del sprint activo |
| 👀 En revisión | Pull requests en revisión de código |
| ✅ Hecho | Funcionalidades completadas y validadas |

---

*Actividad 2 — Sistemas de Información II · Squad [Trabajos sin IA] · 2026*
