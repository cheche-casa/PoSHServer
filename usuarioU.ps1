$conn = New-Object System.Data.OleDb.OleDbConnection;
$conn.ConnectionString = "Provider=SQLOLEDB;Data Source=pccheche;Initial Catalog=Merca;Integrated Security=SSPI;"
$cmd = New-Object System.Data.OleDb.OleDbCommand;
$cmd.Connection = $conn;
try {
    $conn.open();
}
catch {
    Write-Output "$Cerro-$($Error[0].ToString())";
}

$U = $PoSHQuery.U;
$Query = "SELECT COUNT(*) FROM USUARIOS WHERE Id ='$U';";
$cmd.CommandText = $Query;
try {
    $Total = $cmd.ExecuteScalar();
    $Resultado = [PSCustomObject]@{
        usuario = $Total
    }
}
Catch {
    $Resultado = [PSCustomObject]@{
        usuario = 0
    }
}
$Saida = $Resultado|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
