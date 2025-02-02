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
$Query = "SELECT IDENT_CURRENT('[$U].[movementos]') AS Serial;";
$cmd.CommandText = $Query;
$Serial = $cmd.ExecuteScalar();
$Resultado = [PSCustomObject]@{
    serial = $Serial
}
$Saida = $Resultado|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
