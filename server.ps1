# PowerShell HTTP Server for UNIK AudioFlux Engine

param([int]$Port = 3000)

$ProjectPath = $PSScriptRoot

# MIME types
$MimeTypes = @{
    ".html"  = "text/html; charset=utf-8"
    ".js"    = "application/javascript"
    ".css"   = "text/css"
    ".json"  = "application/json"
    ".wasm"  = "application/wasm"
    ".png"   = "image/png"
    ".jpg"   = "image/jpeg"
    ".jpeg"  = "image/jpeg"
    ".gif"   = "image/gif"
    ".svg"   = "image/svg+xml"
    ".txt"   = "text/plain"
}

function Get-FilePath {
    param([string]$RequestPath)
    
    # Default to index.html for root
    if ($RequestPath -eq '/' -or [string]::IsNullOrWhiteSpace($RequestPath)) {
        return Join-Path $ProjectPath 'index.html'
    }
    
    # Remove leading slash
    $Path = $RequestPath -replace '^/', ''
    
    # Return combined path
    return Join-Path $ProjectPath $Path
}

# Find available port
$ListenPort = $Port
$PortTaken = $true
$AttemptCount = 0

while ($PortTaken -and $AttemptCount -lt 10) {
    try {
        $TestListener = New-Object System.Net.HttpListener
        $TestListener.Prefixes.Add("http://localhost:$ListenPort/")
        $TestListener.Start()
        $TestListener.Stop()
        $PortTaken = $false
    } catch {
        $ListenPort++
        $AttemptCount++
    }
}

if ($PortTaken) {
    Write-Host "ERROR: Could not find available port" -ForegroundColor Red
    exit 1
}

# Create HTTP listener
$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add("http://localhost:$ListenPort/")

try {
    $Listener.Start()
    
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host "UNIK AudioFlux Engine - Server Started" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Server URL: http://localhost:$ListenPort" -ForegroundColor Cyan
    Write-Host "Project Path: $ProjectPath" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Opening Chrome..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
    Write-Host ""
    
    # Open Chrome
    try {
        $ChromePath = (Get-Command chrome.exe -ErrorAction SilentlyContinue).Source
        if (-not $ChromePath) {
            $ChromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
            if (-not (Test-Path $ChromePath)) {
                $ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
            }
        }
        if (Test-Path $ChromePath) {
            Start-Process $ChromePath "http://localhost:$ListenPort" -ErrorAction SilentlyContinue
        }
    } catch {}
    
    # Request loop
    while ($Listener.IsListening) {
        $Context = $Listener.GetContext()
        $Request = $Context.Request
        $Response = $Context.Response
        
        try {
            $FilePath = Get-FilePath $Request.Url.LocalPath
            $FileName = Split-Path $FilePath -Leaf
            
            if (Test-Path $FilePath -PathType Leaf) {
                # File exists - serve it
                $Content = [System.IO.File]::ReadAllBytes($FilePath)
                $Ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
                $MimeType = if ($MimeTypes.ContainsKey($Ext)) { $MimeTypes[$Ext] } else { "application/octet-stream" }
                
                $Response.ContentType = $MimeType
                $Response.ContentLength64 = $Content.Length
                $Response.StatusCode = 200
                
                $Response.AddHeader("Cross-Origin-Opener-Policy", "same-origin")
                $Response.AddHeader("Cross-Origin-Embedder-Policy", "require-corp")
                
                # Add CORS headers for WASM
                if ($Ext -eq '.wasm') {
                    $Response.AddHeader("Access-Control-Allow-Origin", "*")
                }
                
                $Response.OutputStream.Write($Content, 0, $Content.Length)
                Write-Host "[$($Request.HttpMethod)] $($Request.Url.LocalPath) [200] ($FileName)" -ForegroundColor Green
            } else {
                # File not found
                $Response.StatusCode = 404
                $Response.ContentType = "text/html; charset=utf-8"
                $NotFoundHtml = @"
<!DOCTYPE html>
<html>
<head>
    <title>404 Not Found</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        h1 { color: #d32f2f; }
    </style>
</head>
<body>
    <h1>404 Not Found</h1>
    <p>The requested file <code>$($Request.Url.LocalPath)</code> was not found.</p>
    <p><a href="http://localhost:$ListenPort">Go back home</a></p>
</body>
</html>
"@
                $NotFoundBytes = [System.Text.Encoding]::UTF8.GetBytes($NotFoundHtml)
                $Response.ContentLength64 = $NotFoundBytes.Length
                $Response.OutputStream.Write($NotFoundBytes, 0, $NotFoundBytes.Length)
                Write-Host "[$($Request.HttpMethod)] $($Request.Url.LocalPath) [404]" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "Error processing request: $_" -ForegroundColor Red
            $Response.StatusCode = 500
        } finally {
            $Response.OutputStream.Close()
        }
    }
} catch {
    Write-Host "Server error: $_" -ForegroundColor Red
    exit 1
} finally {
    if ($Listener) {
        $Listener.Close()
        $Listener.Dispose()
    }
    Write-Host "Server stopped" -ForegroundColor Yellow
}
