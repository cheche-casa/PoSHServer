$conn = New-Object System.Data.OleDb.OleDbConnection;
$conn.ConnectionString= "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=Merca;User Id=********;Password=********;";
$cmd = New-Object System.Data.OleDb.OleDbCommand;
$cmd.Connection = $conn;
try {
    $conn.open();
}
catch {
    Write-Output "$Cerro-$($Error[0].ToString())";
}

$S = $PoSHQuery.S;
$cmd.CommandText = "SELECT serial, comando FROM [dbo].[comandos] WHERE serial > $S ORDER BY serial";

$adapter = New-Object System.Data.OleDb.OleDbDataAdapter $cmd;
$dataset = New-Object System.Data.DataSet;
$Null = $adapter.Fill($dataset);
$Rexistros = $dataset.tables[0];

$Saida = $Rexistros|Select-Object serial, comando|ConvertTo-Json;
If ($Rexistros.Rows.Count -gt 1){
    Write-Output $Saida;
}
else {
    Write-Output "[$Saida]";
}
$conn.close();
