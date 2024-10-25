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

$D = Get-Date($PoSHQuery.D);
$cmd.CommandText = "SELECT data, comando FROM [dbo].[comandos] WHERE data > CONVERT(DATETIME, '$($D)', 102) ORDER BY data";

$adapter = New-Object System.Data.OleDb.OleDbDataAdapter $cmd;
$dataset = New-Object System.Data.DataSet;
$adapter.Fill($dataset);
$Rexistros = $dataset.tables[0];
$Saida = $Rexistros|Select-Object data, comando|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
