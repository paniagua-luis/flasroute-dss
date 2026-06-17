-- ============================================================
-- DSS FlashRoute — Script SQL de Creación de Base de Datos
-- Sistemas de Información II | Universidad Privada Domingo Savio
-- Squad: Cardozo, Yurquina, Paniagua, Pimentel | Junio 2026
-- ============================================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS flashroute_dss
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE flashroute_dss;

-- ============================================================
-- TABLA: usuarios
-- Gestiona todos los usuarios del sistema (gerente, despachadora, conductor)
-- ============================================================
CREATE TABLE usuarios (
    id          INT             NOT NULL AUTO_INCREMENT,
    nombre      VARCHAR(100)    NOT NULL,
    email       VARCHAR(100)    NOT NULL,
    password    VARCHAR(255)    NOT NULL,
    rol         ENUM('gerente','despachadora','conductor') NOT NULL,
    activo      BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuarios      PRIMARY KEY (id),
    CONSTRAINT uq_usuarios_email UNIQUE (email)
);

-- ============================================================
-- TABLA: conductores
-- Extiende usuarios con información específica del conductor
-- ============================================================
CREATE TABLE conductores (
    id              INT             NOT NULL AUTO_INCREMENT,
    usuario_id      INT             NOT NULL,
    licencia        VARCHAR(20)     NOT NULL,
    telefono        VARCHAR(15),
    eficiencia      DECIMAL(5,2)    NOT NULL DEFAULT 0.00,
    disponible      BOOLEAN         NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_conductores        PRIMARY KEY (id),
    CONSTRAINT uq_conductores_lic    UNIQUE (licencia),
    CONSTRAINT uq_conductores_uid    UNIQUE (usuario_id),
    CONSTRAINT fk_conductores_usuario FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT chk_eficiencia CHECK (eficiencia >= 0 AND eficiencia <= 100)
);

-- ============================================================
-- TABLA: vehiculos
-- Flota de camiones de FlashLogistics
-- ============================================================
CREATE TABLE vehiculos (
    id              INT             NOT NULL AUTO_INCREMENT,
    placa           VARCHAR(10)     NOT NULL,
    capacidad_kg    DECIMAL(8,2)    NOT NULL,
    combustible     ENUM('diesel','gasolina','gas') NOT NULL DEFAULT 'diesel',
    estado          ENUM('activo','inactivo','mantenimiento') NOT NULL DEFAULT 'activo',
    km_actuales     INT             NOT NULL DEFAULT 0,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_vehiculos     PRIMARY KEY (id),
    CONSTRAINT uq_vehiculos_placa UNIQUE (placa),
    CONSTRAINT chk_capacidad    CHECK (capacidad_kg > 0),
    CONSTRAINT chk_km           CHECK (km_actuales >= 0)
);

-- ============================================================
-- TABLA: clientes
-- Empresas clientes B2B de FlashLogistics
-- ============================================================
CREATE TABLE clientes (
    id              INT             NOT NULL AUTO_INCREMENT,
    razon_social    VARCHAR(150)    NOT NULL,
    telefono        VARCHAR(15),
    email           VARCHAR(100),
    direccion       TEXT            NOT NULL,
    coord_lat       DECIMAL(10,7),
    coord_lng       DECIMAL(10,7),
    activo          BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_clientes      PRIMARY KEY (id),
    CONSTRAINT uq_clientes_email UNIQUE (email)
);

-- ============================================================
-- TABLA: pedidos
-- Pedidos de distribución a entregar
-- ============================================================
CREATE TABLE pedidos (
    id              INT             NOT NULL AUTO_INCREMENT,
    cliente_id      INT             NOT NULL,
    vehiculo_id     INT,
    codigo          VARCHAR(20)     NOT NULL,
    descripcion     TEXT,
    peso_kg         DECIMAL(8,2)    NOT NULL,
    estado          ENUM('pendiente','asignado','en_ruta','entregado','fallido')
                                    NOT NULL DEFAULT 'pendiente',
    ventana_inicio  TIME,
    ventana_fin     TIME,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    entregado_at    TIMESTAMP,
    CONSTRAINT pk_pedidos           PRIMARY KEY (id),
    CONSTRAINT uq_pedidos_codigo    UNIQUE (codigo),
    CONSTRAINT fk_pedidos_cliente   FOREIGN KEY (cliente_id)
        REFERENCES clientes(id) ON DELETE RESTRICT,
    CONSTRAINT fk_pedidos_vehiculo  FOREIGN KEY (vehiculo_id)
        REFERENCES vehiculos(id) ON DELETE SET NULL,
    CONSTRAINT chk_peso             CHECK (peso_kg > 0)
);

-- ============================================================
-- TABLA: rutas
-- Rutas planificadas por el algoritmo de optimización
-- ============================================================
CREATE TABLE rutas (
    id              INT             NOT NULL AUTO_INCREMENT,
    vehiculo_id     INT             NOT NULL,
    conductor_id    INT             NOT NULL,
    aprobada_por    INT,
    fecha           DATE            NOT NULL,
    distancia_km    DECIMAL(8,2),
    tiempo_est_min  INT,
    costo_estimado  DECIMAL(10,2),
    costo_real      DECIMAL(10,2),
    estado          ENUM('planificada','activa','completada','interrumpida')
                                    NOT NULL DEFAULT 'planificada',
    aprobada_at     TIMESTAMP,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_rutas             PRIMARY KEY (id),
    CONSTRAINT fk_rutas_vehiculo    FOREIGN KEY (vehiculo_id)
        REFERENCES vehiculos(id) ON DELETE RESTRICT,
    CONSTRAINT fk_rutas_conductor   FOREIGN KEY (conductor_id)
        REFERENCES conductores(id) ON DELETE RESTRICT,
    CONSTRAINT fk_rutas_aprobador   FOREIGN KEY (aprobada_por)
        REFERENCES usuarios(id) ON DELETE SET NULL,
    CONSTRAINT chk_costo_est        CHECK (costo_estimado IS NULL OR costo_estimado > 0),
    CONSTRAINT chk_distancia        CHECK (distancia_km IS NULL OR distancia_km > 0)
);

-- ============================================================
-- TABLA: ruta_pedidos (tabla intermedia Ruta ↔ Pedido)
-- ============================================================
CREATE TABLE ruta_pedidos (
    ruta_id         INT             NOT NULL,
    pedido_id       INT             NOT NULL,
    orden           INT             NOT NULL,
    entregado       BOOLEAN         NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_ruta_pedidos      PRIMARY KEY (ruta_id, pedido_id),
    CONSTRAINT fk_rp_ruta           FOREIGN KEY (ruta_id)
        REFERENCES rutas(id) ON DELETE CASCADE,
    CONSTRAINT fk_rp_pedido         FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id) ON DELETE CASCADE
);

-- ============================================================
-- TABLA: posiciones_gps
-- Historial de posiciones GPS de cada ruta (trazabilidad)
-- ============================================================
CREATE TABLE posiciones_gps (
    id              BIGINT          NOT NULL AUTO_INCREMENT,
    ruta_id         INT             NOT NULL,
    latitud         DECIMAL(10,7)   NOT NULL,
    longitud        DECIMAL(10,7)   NOT NULL,
    velocidad       DECIMAL(5,2)    DEFAULT 0.00,
    timestamp       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    desvio          BOOLEAN         NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_posiciones        PRIMARY KEY (id),
    CONSTRAINT fk_pos_ruta          FOREIGN KEY (ruta_id)
        REFERENCES rutas(id) ON DELETE CASCADE,
    CONSTRAINT chk_latitud          CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT chk_longitud         CHECK (longitud BETWEEN -180 AND 180)
);

-- ============================================================
-- TABLA: alertas
-- Alertas generadas por el sistema (desvíos, retrasos, averías)
-- ============================================================
CREATE TABLE alertas (
    id              INT             NOT NULL AUTO_INCREMENT,
    ruta_id         INT             NOT NULL,
    conductor_id    INT,
    tipo            ENUM('desvio','retraso','averia','entrega_fallida')
                                    NOT NULL,
    mensaje         TEXT            NOT NULL,
    leida           BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_alertas           PRIMARY KEY (id),
    CONSTRAINT fk_alertas_ruta      FOREIGN KEY (ruta_id)
        REFERENCES rutas(id) ON DELETE CASCADE,
    CONSTRAINT fk_alertas_conductor FOREIGN KEY (conductor_id)
        REFERENCES conductores(id) ON DELETE SET NULL
);

-- ============================================================
-- TABLA: notificaciones
-- Notificaciones enviadas a clientes (WhatsApp/SMS/Email)
-- ============================================================
CREATE TABLE notificaciones (
    id              INT             NOT NULL AUTO_INCREMENT,
    pedido_id       INT             NOT NULL,
    cliente_id      INT             NOT NULL,
    canal           ENUM('whatsapp','sms','email') NOT NULL DEFAULT 'whatsapp',
    contenido       TEXT            NOT NULL,
    enviada         BOOLEAN         NOT NULL DEFAULT FALSE,
    enviado_at      TIMESTAMP,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_notificaciones    PRIMARY KEY (id),
    CONSTRAINT fk_notif_pedido      FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id) ON DELETE CASCADE,
    CONSTRAINT fk_notif_cliente     FOREIGN KEY (cliente_id)
        REFERENCES clientes(id) ON DELETE CASCADE
);

-- ============================================================
-- TABLA: kpis_diarios
-- KPIs calculados al cierre de cada jornada (Dashboard analítico)
-- ============================================================
CREATE TABLE kpis_diarios (
    id                      INT         NOT NULL AUTO_INCREMENT,
    fecha                   DATE        NOT NULL,
    total_pedidos           INT         NOT NULL DEFAULT 0,
    pedidos_a_tiempo        INT         NOT NULL DEFAULT 0,
    pedidos_tardios         INT         NOT NULL DEFAULT 0,
    pedidos_fallidos        INT         NOT NULL DEFAULT 0,
    pct_entrega_tiempo      DECIMAL(5,2) GENERATED ALWAYS AS
                            (CASE WHEN total_pedidos > 0
                             THEN (pedidos_a_tiempo * 100.0 / total_pedidos)
                             ELSE 0 END) STORED,
    km_totales              DECIMAL(10,2) NOT NULL DEFAULT 0,
    costo_total             DECIMAL(12,2) NOT NULL DEFAULT 0,
    costo_por_km            DECIMAL(8,4) GENERATED ALWAYS AS
                            (CASE WHEN km_totales > 0
                             THEN costo_total / km_totales
                             ELSE 0 END) STORED,
    created_at              TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_kpis      PRIMARY KEY (id),
    CONSTRAINT uq_kpis_fecha UNIQUE (fecha)
);

-- ============================================================
-- ÍNDICES para optimizar consultas del DSS
-- ============================================================
CREATE INDEX idx_pedidos_estado    ON pedidos(estado);
CREATE INDEX idx_pedidos_cliente   ON pedidos(cliente_id);
CREATE INDEX idx_pedidos_fecha     ON pedidos(created_at);
CREATE INDEX idx_rutas_fecha       ON rutas(fecha);
CREATE INDEX idx_rutas_estado      ON rutas(estado);
CREATE INDEX idx_posiciones_ruta   ON posiciones_gps(ruta_id);
CREATE INDEX idx_posiciones_ts     ON posiciones_gps(timestamp);
CREATE INDEX idx_alertas_ruta      ON alertas(ruta_id);
CREATE INDEX idx_alertas_leida     ON alertas(leida);
CREATE INDEX idx_kpis_fecha        ON kpis_diarios(fecha);

-- ============================================================
-- DATOS INICIALES (seed)
-- ============================================================
INSERT INTO usuarios (nombre, email, password, rol) VALUES
('Carlos Mendoza',  'gerente@flashlogistics.com',     SHA2('Admin2026!',256), 'gerente'),
('Ana Torres',      'despacho@flashlogistics.com',    SHA2('Desp2026!',256),  'despachadora'),
('Pedro Quispe',    'pedro.quispe@flashlogistics.com',SHA2('Cond2026!',256),  'conductor');

INSERT INTO clientes (razon_social, telefono, email, direccion, coord_lat, coord_lng) VALUES
('Supermercados Norte S.A.',  '67712345', 'compras@supernorte.com',  'Av. Las Américas 234, Tarija', -21.5355, -64.7296),
('Distribuidora Central Ltda.','72298765','logistica@distcentral.com','Calle Colón 567, Tarija',      -21.5278, -64.7312);

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
