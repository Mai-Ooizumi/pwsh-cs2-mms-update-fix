$CS2DS_DIR = ""
$GAMEINFO_FILE = "game/csgo/gameinfo.gi"
$METAMOD_ENTRY = "`n            Game    csgo/addons/metamod // metamod:source entry `n"
$PATTERN = "Game_LowViolence"

function updateFile {
    # find pattern
    $searchResults = Select-String -Path $GAMEINFO_FILE -Pattern $PATTERN
    # read gameinfo.gi file
    $fileContent = Get-Content $GAMEINFO_FILE
    # array index start at zero
    $fileContent[$searchResults.LineNumber] = $METAMOD_ENTRY
    # write file
    Set-Content -Path $GAMEINFO_FILE -Value $fileContent

    Write-Host "gameinfo.gi has been modified successfully."
}

if (-Not (Test-Path $CS2DS_DIR)) {
    Write-Warning "$CS2DS_DIR does not exist, using current folder..."
    $CS2DS_DIR = Get-Location
}

Set-Location $CS2DS_DIR

if (-Not (Test-Path $GAMEINFO_FILE)) {
    Write-Error "gameinfo.gi does not exist, exiting..."
    exit
}

if (Select-String -Path $GAMEINFO_FILE -Pattern "metamod") {
    Write-Error "Metamod:Source entry already exists in gameinfo.gi , exiting..."
    exit
}

updateFile
