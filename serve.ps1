# File to serve
$FilePath = D:\server\index.html
# Check if file exists
if (-Not (Test-Path $FilePath)) {
    Write-Host Error File $FilePath not found!
    exit
}

# HTTP response header
$Header = HTTP1.1 200 OK`r`nContent-Type textplain`r`nConnection close`r`n`r`n
$FileContent = Get-Content -Path $FilePath -Raw

# Create TCP listener on port 80
$Listener = New-Object System.Net.Sockets.TcpListener('0.0.0.0', 80)
$Listener.Start()
Write-Host Server started. Listening on port 80...

# Infinite loop to handle requests
while ($true) {
    $Client = $Listener.AcceptTcpClient()
    Write-Host Connection received from $($Client.Client.RemoteEndPoint)

    # Get the network stream
    $Stream = $Client.GetStream()
    $Writer = New-Object System.IO.StreamWriter($Stream)
    $Writer.AutoFlush = $true

    # Send the header and file content
    $Writer.Write($Header)
    $Writer.Write($FileContent)

    # Close the connection
    $Writer.Close()
    $Stream.Close()
    $Client.Close()
}

# Stop listener (unreachable due to infinite loop, use Ctrl+C to stop)
$Listener.Stop()