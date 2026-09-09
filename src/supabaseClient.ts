import { createClient } from '@supabase/supabase-js';

// ⚠️ IMPORTANTE: Reemplazá estas credenciales con las de tu proyecto Supabase
// Las encontrás en: Settings → API → Project URL y anon public key

const supabaseUrl = 'https://ovfwcbjkqtyeqkadvnlz.supabase.co';
const supabaseAnonKey = 'REEMPLAZAR_CON_CLAVE_ANON_CORRECTA';

// Verificar que las credenciales estén configuradas
if (supabaseAnonKey === 'REEMPLAZAR_CON_CLAVE_ANON_CORRECTA') {
  console.warn('⚠️ Supabase no configurado. Editá src/supabaseClient.ts con tus credenciales.');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Tipos para TypeScript (deben coincidir con las tablas de Supabase)
export interface AlumnoDB {
  id: string;
  nombre: string;
  apellido: string;
  dni?: string;
  categoria: 'domiciliarios' | 'hospitalarios' | 'hogares' | 'otros';
  escuela_origen: string;
  grado: string;
  establecimiento: string;
  tutor?: string;
  estado: 'activo' | 'pausado' | 'egresado';
  fecha_alta: string;
  diagnostico?: string;
  observaciones?: string;
  created_at?: string;
  updated_at?: string;
}

export interface ActividadDB {
  id: string;
  titulo: string;
  fecha: string;
  hora?: string;
  categoria: 'domiciliarios' | 'hospitalarios' | 'hogares' | 'otros';
  alumno_ids: string[];
  area: string;
  duracion?: string;
  objetivo?: string;
  consignas: string;
  recursos?: string;
  realizada: boolean;
  created_at?: string;
  updated_at?: string;
}
