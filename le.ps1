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

$S = $PoSHQuery.S;
$cmd.CommandText = "SELECT serial, comando FROM [dbo].[comandos] WHERE serial > $S ORDER BY serial";

$adapter = New-Object System.Data.OleDb.OleDbDataAdapter $cmd;
$dataset = New-Object System.Data.DataSet;
$Null = $adapter.Fill($dataset);
$Rexistros = $dataset.tables[0];

$Saida = $Rexistros|Select-Object serial, comando|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
