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

$S = $PoSHQuery.S;
$U = $PoSHQuery.U;
$cmd.CommandText = "SELECT serial, tipo, taboa, chave, valores FROM [$U].[movementos] WHERE serial > $S ORDER BY serial";

$adapter = New-Object System.Data.OleDb.OleDbDataAdapter $cmd;
$dataset = New-Object System.Data.DataSet;
$Null = $adapter.Fill($dataset);
$Rexistros = $dataset.tables[0];

$Saida = $Rexistros|Select-Object serial, tipo, taboa, chave, valores|ConvertTo-Json;
If ($Rexistros.Rows.Count -gt 1){
    Write-Output $Saida;
}
else {
    Write-Output "[$Saida]";
}
$conn.close();
