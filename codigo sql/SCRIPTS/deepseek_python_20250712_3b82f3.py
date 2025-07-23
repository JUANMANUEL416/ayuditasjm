import os
import zipfile
import shutil
from pathlib import Path

# Configuraciones iniciales
NOMBRE_FIJO = "900986941"
RUTA_BASE = os.getcwd()

def paso_1_extraer_zips():
    """Extrae todos los archivos ZIP en carpetas con su mismo nombre"""
    print("\n[PASO 1] Extrayendo archivos ZIP...\n")
    
    for zip_file in Path('.').glob('*.zip'):
        folder_name = zip_file.stem
        folder_path = Path(folder_name)
        
        print(f"Extrayendo: {zip_file.name}")
        
        # Crear directorio si no existe
        folder_path.mkdir(exist_ok=True)
        
        # Extraer contenido
        with zipfile.ZipFile(zip_file, 'r') as zip_ref:
            zip_ref.extractall(folder_path)
    
    print("Extracción completada.\n")

def paso_2_limpiar_archivos():
    """Elimina archivos XML y PDF de todas las subcarpetas"""
    print("[PASO 2] Limpiando archivos temporales...\n")
    
    for folder in Path('.').iterdir():
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
    """Renombra archivos JSON según el formato requerido"""
    print("[PASO 3] Renombrando archivos JSON...\n")
    
    for folder in Path('.').iterdir():
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
            
            print()
    
    print("Renombrado completado.\n")

def paso_4_comprimir_carpetas():
    """Comprime las carpetas procesadas en archivos ZIP"""
    print("[PASO 4] Comprimiendo carpetas procesadas...\n")
    
    for folder in Path('.').iterdir():
        if folder.is_dir():
            nombre_base = folder.name.split('_')[0]
            zip_name = f"{NOMBRE_FIJO}_{nombre_base}.zip"
            
            print(f"Comprimiendo: {folder.name}")
            
            # Crear archivo ZIP
            shutil.make_archive(zip_name[:-4], 'zip', folder)
            print(f"Archivo creado: {zip_name}\n")
    
    print("Compresión finalizada.\n")

def main():
    print("\n" + "="*50)
    print("  PROCESO AUTOMATIZADO DE ARCHIVOS")
    print("="*50 + "\n")
    
    try:
        paso_1_extraer_zips()
        paso_2_limpiar_archivos()
        paso_3_renombrar_json()
        paso_4_comprimir_carpetas()
        
        print("\n" + "="*50)
        print("  PROCESO COMPLETADO CON ÉXITO")
        print("="*50 + "\n")
        
    except Exception as e:
        print(f"\n[ERROR] Ocurrió un problema: {str(e)}")
    
    input("Presione Enter para salir...")

if __name__ == "__main__":
    main()