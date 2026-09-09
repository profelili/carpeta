-- ============================================
-- CARPETA DIDÁCTICA - Esquema de Base de Datos
-- ============================================
-- 
-- INSTRUCCIONES:
-- 1. Andá a tu proyecto en Supabase
-- 2. En el menú izquierdo, hacé clic en "SQL Editor" (ícono de código)
-- 3. Hacé clic en "New query"
-- 4. Copiá y pegá TODO este código SQL
-- 5. Hacé clic en "Run" (botón verde)
-- 
-- Esto creará las tablas necesarias para alumnos y actividades
-- ============================================

-- ============================================
-- TABLA: alumnos
-- ============================================
CREATE TABLE IF NOT EXISTS alumnos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  apellido TEXT NOT NULL,
  dni TEXT,
  categoria TEXT NOT NULL CHECK (categoria IN ('domiciliarios', 'hospitalarios', 'hogares', 'otros')),
  escuela_origen TEXT NOT NULL,
  grado TEXT NOT NULL,
  establecimiento TEXT NOT NULL,
  tutor TEXT,
  estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo', 'pausado', 'egresado')),
  fecha_alta DATE NOT NULL DEFAULT CURRENT_DATE,
  diagnostico TEXT,
  observaciones TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- TABLA: actividades
-- ============================================
CREATE TABLE IF NOT EXISTS actividades (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo TEXT NOT NULL,
  fecha DATE NOT NULL,
  hora TEXT,
  categoria TEXT NOT NULL CHECK (categoria IN ('domiciliarios', 'hospitalarios', 'hogares', 'otros')),
  alumno_ids UUID[] DEFAULT '{}',
  area TEXT NOT NULL,
  duracion TEXT,
  objetivo TEXT,
  consignas TEXT NOT NULL,
  recursos TEXT,
  realizada BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- ÍNDICES para mejorar performance
-- ============================================
CREATE INDEX IF NOT EXISTS idx_alumnos_categoria ON alumnos(categoria);
CREATE INDEX IF NOT EXISTS idx_alumnos_estado ON alumnos(estado);
CREATE INDEX IF NOT EXISTS idx_actividades_fecha ON actividades(fecha);
CREATE INDEX IF NOT EXISTS idx_actividades_categoria ON actividades(categoria);
CREATE INDEX IF NOT EXISTS idx_actividades_realizada ON actividades(realizada);

-- ============================================
-- FUNCIÓN: Actualizar updated_at automáticamente
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para alumnos
DROP TRIGGER IF EXISTS update_alumnos_updated_at ON alumnos;
CREATE TRIGGER update_alumnos_updated_at
  BEFORE UPDATE ON alumnos
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Trigger para actividades
DROP TRIGGER IF EXISTS update_actividades_updated_at ON actividades;
CREATE TRIGGER update_actividades_updated_at
  BEFORE UPDATE ON actividades
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- POLÍTICAS DE SEGURIDAD (RLS - Row Level Security)
-- ============================================
-- Por ahora, permitimos todo (lectura y escritura) sin autenticación
-- En el futuro, podés agregar autenticación para proteger los datos

ALTER TABLE alumnos ENABLE ROW LEVEL SECURITY;
ALTER TABLE actividades ENABLE ROW LEVEL SECURITY;

-- Permitir lectura pública
CREATE POLICY "Permitir lectura pública de alumnos" ON alumnos
  FOR SELECT USING (true);

CREATE POLICY "Permitir lectura pública de actividades" ON actividades
  FOR SELECT USING (true);

-- Permitir inserción pública
CREATE POLICY "Permitir inserción pública de alumnos" ON alumnos
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Permitir inserción pública de actividades" ON actividades
  FOR INSERT WITH CHECK (true);

-- Permitir actualización pública
CREATE POLICY "Permitir actualización pública de alumnos" ON alumnos
  FOR UPDATE USING (true);

CREATE POLICY "Permitir actualización pública de actividades" ON actividades
  FOR UPDATE USING (true);

-- Permitir eliminación pública
CREATE POLICY "Permitir eliminación pública de alumnos" ON alumnos
  FOR DELETE USING (true);

CREATE POLICY "Permitir eliminación pública de actividades" ON actividades
  FOR DELETE USING (true);

-- ============================================
-- ¡LISTO! Las tablas están creadas
-- ============================================
-- Ahora podés verificar en "Table Editor" que aparezcan las tablas
-- "alumnos" y "actividades"
