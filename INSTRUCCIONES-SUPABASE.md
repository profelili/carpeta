# 🗄️ Configuración de Supabase - Paso a Paso

## Paso 1: Crear las tablas en Supabase

1. **Andá a tu proyecto en Supabase**
   - URL: https://supabase.com/dashboard/
   - Seleccioná tu proyecto

2. **Abrí el SQL Editor**
   - En el menú de la izquierda, buscá el ícono de código `<>` (SQL Editor)
   - Hacé clic en **"New query"**

3. **Copiá y pegá el SQL**
   - Abrí el archivo `supabase-schema.sql` de este proyecto
   - Copiá TODO el contenido
   - Pegalo en el SQL Editor de Supabase

4. **Ejecutá el SQL**
   - Hacé clic en el botón **"Run"** (verde, abajo a la derecha)
   - Deberías ver un mensaje de éxito

5. **Verificá que se crearon las tablas**
   - En el menú izquierdo, hacé clic en **"Table Editor"** (ícono de tabla)
   - Deberías ver dos tablas: `alumnos` y `actividades`

## Paso 2: Obtener las credenciales correctas

1. **Andá a Settings**
   - En el menú izquierdo, hacé clic en el ícono de engranaje ⚙️ (Settings)
   - Luego hacé clic en **"API"**

2. **Copiá las credenciales**
   - **Project URL**: Es la URL de tu proyecto (ej: `https://xxxxx.supabase.co`)
   - **Project API keys → anon public**: Es una clave larga que empieza con `eyJ...`

3. **Actualizá el archivo de configuración**
   - Abrí el archivo `src/supabaseClient.ts`
   - Reemplazá las variables:
     ```typescript
     const supabaseUrl = 'TU_URL_AQUI';
     const supabaseAnonKey = 'TU_CLAVE_ANON_AQUI';
     ```

## Paso 3: Verificar que funciona

1. **Ejecutá la aplicación**
   ```bash
   npm run dev
   ```

2. **Agregá un alumno de prueba**
   - Abrí la app en el navegador
   - Agregá un alumno nuevo
   - Andá al **Table Editor** de Supabase
   - Deberías ver el alumno en la tabla `alumnos`

3. **Verificá la sincronización**
   - Si abrís la app en otro navegador o dispositivo
   - Deberías ver los mismos datos

## 🎉 ¡Listo!

Tu aplicación ahora usa Supabase en lugar de localStorage. Los datos se sincronizan en tiempo real.

## 🔒 Seguridad (Opcional - Futuro)

Por ahora, la base de datos está configurada para permitir acceso público (lectura y escritura). Esto es suficiente para uso personal.

Si en el futuro querés agregar autenticación (login de usuarios), Supabase tiene un sistema de autenticación integrado muy fácil de usar.

## 📊 Estructura de las tablas

### Tabla `alumnos`
- `id`: UUID (identificador único)
- `nombre`, `apellido`: Texto
- `dni`: Texto (opcional)
- `categoria`: Enum (domiciliarios, hospitalarios, hogares, otros)
- `escuela_origen`, `grado`, `establecimiento`: Texto
- `tutor`: Texto (opcional)
- `estado`: Enum (activo, pausado, egresado)
- `fecha_alta`: Fecha
- `diagnostico`, `observaciones`: Texto (opcional)
- `created_at`, `updated_at`: Timestamps automáticos

### Tabla `actividades`
- `id`: UUID (identificador único)
- `titulo`: Texto
- `fecha`: Fecha
- `hora`: Texto (opcional)
- `categoria`: Enum (domiciliarios, hospitalarios, hogares, otros)
- `alumno_ids`: Array de UUIDs (referencias a alumnos)
- `area`: Texto
- `duracion`, `objetivo`, `consignas`, `recursos`: Texto
- `realizada`: Booleano
- `created_at`, `updated_at`: Timestamps automáticos

## 🆘 ¿Problemas?

Si algo no funciona:
1. Verificá que copiaste TODO el SQL
2. Verificá que las credenciales están bien copiadas (sin espacios extra)
3. Revisá la consola del navegador (F12) para ver errores
