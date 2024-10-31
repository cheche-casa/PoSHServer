$conn = New-Object System.Data.OleDb.OleDbConnection;
$conn.ConnectionString= "Provider=SQLOLEDB;Data Source=pccheche;Initial Catalog=Merca;User Id=poshserver;Password=N0cturn1dade;";
$cmd = New-Object System.Data.OleDb.OleDbCommand;
$cmd.Connection = $conn;
try {
    $conn.open();
}
catch {
    Write-Output "$Cerro-$($Error[0].ToString())";
}

$C = $PoSHQuery.C;
$Query = "INSERT INTO [dbo].[comandos] ([comando]) VALUES ('$($C)');SELECT SCOPE_IDENTITY() AS NewID;";
$cmd.CommandText = $Query;
$Serial = $cmd.ExecuteScalar();
$Resultado = [PSCustomObject]@{
    serial = $Serial
}
$Saida = $Resultado|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
