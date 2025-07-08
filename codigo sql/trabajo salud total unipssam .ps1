$zipFolder = "F:\ARCHIVOS STOTAL\SALUD TOTAL RIPS MAYO TODOS"  # Carpeta que contiene los archivos ZIP
$extractBase = "F:\ARCHIVOS STOTAL\SALUD TOTAL RIPS MAYO TODOS\temporal"  # Carpeta base para la extracción
$finalFolder = "F:\ARCHIVOS STOTAL\SALUD TOTAL RIPS MAYO TODOS\NUEVOS"    # Carpeta donde se guardarán los nuevos ZIP

# Crear carpeta de destino si no existe
if (!(Test-Path $finalFolder)) {
    New-Item -ItemType Directory -Path $finalFolder
}

# Procesar cada archivo ZIP en la carpeta
Get-ChildItem -Path $zipFolder -Filter *.zip | ForEach-Object {
    $zipPath = $_.FullName
    $extractPath = "$extractBase\$($_.BaseName)"  # Carpeta única por ZIP
    #$newZipPath = "$finalFolder\$($_.BaseName).zip"
	
    $zipBaseName = $_.BaseName -replace "_FEVRIPS", ""  # Eliminar "_FEVRIPS"
    $newZipName = "900986941_$zipBaseName.zip"  # Agregar "111_" al inicio
    $newZipPath = "$finalFolder\$newZipName"  # Ruta para el nuevo ZIP
	

    # Descomprimir el ZIP
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

    # Eliminar archivos específicos
    Remove-Item "$extractPath\*.xml" -ErrorAction SilentlyContinue
    Remove-Item "$extractPath\*.pdf" -ErrorAction SilentlyContinue

    # Renombrar archivos
	$jsonFiles = Get-ChildItem -Path $extractPath -Filter *.json
	$jsonWithUnderscore = $jsonFiles | Where-Object { $_.Name -match "_" }
	$jsonWithoutUnderscore = $jsonFiles | Where-Object { $_.Name -notmatch "_" }


	foreach ($file in $jsonWithUnderscore) {
		$newName = "900986941_"+$file.BaseName +".json"  # Quita .json y añade _RIPS.json
		$newPath = "$($file.DirectoryName)\$newName"
		Rename-Item -Path $file.FullName -NewName $newName
	}	
	
	foreach ($file in $jsonWithoutUnderscore) {
		$newName = "900986941_"+$file.BaseName + "_RIPS.json"  # Quita .json y añade _RIPS.json
		$newPath = "$($file.DirectoryName)\$newName"
		Rename-Item -Path $file.FullName -NewName $newName
	}


    # Volver a comprimir los archivos restantes
    Compress-Archive -Path "$extractPath\*" -DestinationPath $newZipPath -Force

    # Eliminar carpeta temporal de extracción
    Remove-Item -Recurse -Force $extractPath
}

Write-Host "Proceso completado para todos los archivos ZIP en la carpeta."