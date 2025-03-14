$conn = New-Object System.Data.OleDb.OleDbConnection;
$conn.ConnectionString = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=Merca;Integrated Security=SSPI;"
$cmd = New-Object System.Data.OleDb.OleDbCommand;
$cmd.Connection = $conn;
try {
    $conn.open();
}
catch {
    Write-Output "$Cerro-$($Error[0].ToString())";
}

$U = $PoSHQuery.U;

If ($U -eq "importar"){
    $Query = "SELECT 0;"
}
eLSE{
    $Query = "SELECT Version FROM USUARIOS WHERE Id ='$U';";
}

$cmd.CommandText = $Query;
try {
    $Version = $cmd.ExecuteScalar();
    $Resultado = [PSCustomObject]@{
        version = $Version
    }
}
Catch {
    $Resultado = [PSCustomObject]@{
        version = 0
    }
}
$Saida = $Resultado|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
