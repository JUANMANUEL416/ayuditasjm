import os
import zipfile
import shutil
from pathlib import Path
import tkinter as tk
from tkinter import messagebox

# Configuraciones iniciales
NOMBRE_FIJO = "900986941"
RUTA_BASE = os.getcwd()
CARPETA_EXTRACCION = "Procesados"  # Nueva carpeta para extracción

def mostrar_ventana_finalizacion():
    """Muestra ventana emergente al completar el proceso"""
    root = tk.Tk()
    root.withdraw()  # Oculta la ventana principal
    
    # Ventana de información
    messagebox.showinfo(
        title="Proceso Completado",
        message="✅ Todos los archivos han sido procesados correctamente.\n\n"
                f"Los ZIPs finales están en: {CARPETA_EXTRACCION}\n"
                f"Las carpetas originales han sido eliminadas.",
        icon=messagebox.INFO
    )
    
    root.destroy()

def eliminar_carpeta_segura(ruta):
    """Elimina una carpeta con manejo de errores"""
    try:
        if ruta.exists() and ruta.is_dir():
            shutil.rmtree(ruta)
            print(f"✔ Carpeta {ruta.name} eliminada correctamente")
            return True
        return False
    except PermissionError:
        print(f"✖ Error: No hay permisos para eliminar {ruta.name}")
    except Exception as e:
        print(f"✖ Error inesperado al eliminar {ruta.name}: {str(e)}")
    return False

def paso_1_extraer_zips():
    """Extrae todos los archivos ZIP en una subcarpeta específica"""
    print("\n[PASO 1] Extrayendo archivos ZIP...\n")
    
    # Crear carpeta de extracción si no existe
    Path(CARPETA_EXTRACCION).mkdir(exist_ok=True)
    
    for zip_file in Path('.').glob('*.zip'):
        folder_name = zip_file.stem
        folder_path = Path(CARPETA_EXTRACCION) / folder_name  # Ruta completa
        
        print(f"Extrayendo: {zip_file.name} → {folder_path}")
        
        # Crear subdirectorio si no existe
        folder_path.mkdir(exist_ok=True)
        
        # Extraer contenido
        with zipfile.ZipFile(zip_file, 'r') as zip_ref:
            zip_ref.extractall(folder_path)
    
    print(f"\nExtracción completada en: {CARPETA_EXTRACCION}/\n")

def paso_2_limpiar_archivos():
    """Elimina archivos XML y PDF de la carpeta de extracción"""
    print("[PASO 2] Limpiando archivos temporales...\n")
    
    for folder in Path(CARPETA_EXTRACCION).iterdir():
        if folder.is_dir():
            # Eliminar XML
            for xml_file in folder.glob('*.xml'):
                print(f"Eliminando XML en: {folder.name}")
                xml_file.unlink()
            
            # Eliminar PDF
            for pdf_file in folder.glob('*.pdf'):
                print(f"Eliminando PDF en: {folder.name}")
                pdf_file.unlink()
    
    print("Limpieza completada.\n")

def paso_3_renombrar_json():
    """Renombra archivos JSON en la carpeta de extracción"""
    print("[PASO 3] Renombrando archivos JSON...\n")
    
    for folder in Path(CARPETA_EXTRACCION).iterdir():
        if folder.is_dir():
            folder_name = folder.name
            nombre_base = folder_name.split('_')[0]
            
            print(f"Procesando carpeta: {folder_name}")
            
            # Renombrar _CUV.json
            cuv_file = folder / f"{nombre_base}_CUV.json"
            if cuv_file.exists():
                new_cuv_name = f"{NOMBRE_FIJO}_{nombre_base}_CUV.json"
                print(f"Renombrando: {cuv_file.name} -> {new_cuv_name}")
                cuv_file.rename(folder / new_cuv_name)
            else:
                print(f"No se encontró: {nombre_base}_CUV.json")
            
            # Renombrar .json (RIPS)
            rips_file = folder / f"{nombre_base}.json"
            if rips_file.exists():
                new_rips_name = f"{NOMBRE_FIJO}_{nombre_base}_RIPS.json"
                print(f"Renombrando: {rips_file.name} -> {new_rips_name}")
                rips_file.rename(folder / new_rips_name)
            else:
                print(f"No se encontró: {nombre_base}.json")
                
    print("Renombrado completado.\n")

def paso_4_comprimir_y_limpiar():
    """Comprime carpetas y luego las elimina con manejo de errores"""
    print("\n[PASO 4] Comprimiendo y limpiando...\n")
    
    try:
        # Crear carpeta para zips finales
        Path(CARPETA_EXTRACCION).mkdir(exist_ok=True)
        
        for folder in Path(CARPETA_EXTRACCION).iterdir():
            if not folder.is_dir():
                continue
                
            try:
                nombre_base = folder.name.split('_')[0]
                zip_name = f"{NOMBRE_FIJO}_{nombre_base}.zip"
                zip_path = Path(CARPETA_EXTRACCION) / zip_name
                
                print(f"\nProcesando: {folder.name}")
                
                # 1. Comprimir
                try:
                    shutil.make_archive(
                        str(zip_path.with_suffix('')),
                        'zip',
                        folder
                    )
                    print(f"✔ ZIP creado: {zip_path}")
                except Exception as e:
                    print(f"✖ Error al comprimir {folder.name}: {str(e)}")
                    continue
                
                # 2. Eliminar solo si el ZIP se creó correctamente
                if zip_path.exists():
                    if not eliminar_carpeta_segura(folder):
                        print("⚠ La carpeta no fue eliminada, pero el ZIP está creado")
                else:
                    print("✖ El ZIP no se creó, se omite eliminación")
                    
            except Exception as e:
                print(f"✖ Error procesando {folder.name}: {str(e)}")
                continue
                
    except Exception as e:
        print(f"\n✖✖ Error crítico en paso 4: {str(e)}")

    mostrar_ventana_finalizacion()    
    print("\n✅ Proceso completado")

def main():
    print("\n" + "="*50)
    print(f"  PROCESO AUTOMATIZADO (Archivos en: {CARPETA_EXTRACCION}/)")
    print("="*50 + "\n")
    
    try:
        paso_1_extraer_zips()
        paso_2_limpiar_archivos()
        paso_3_renombrar_json()
        paso_4_comprimir_y_limpiar()
        
        print("\n" + "="*50)
        print(f"  RESULTADOS:")
        print(f"  - Extracción: {CARPETA_EXTRACCION}/")
        print(f"  - ZIPs finales: {RUTA_BASE}/")
        print("="*50 + "\n")
        
    except Exception as e:
        print(f"\n[ERROR] Ocurrió un problema: {str(e)}")
    
    input("Presione Enter para salir...")

if __name__ == "__main__":
    main()