$conn = New-Object System.Data.OleDb.OleDbConnection;
$conn.ConnectionString= "Provider=SQLOLEDB;Data Source=fuegovm.rpso.usc.es;Initial Catalog=SQLHealth;User Id=probas;Password=N0cturn1dade;";
$cmd = New-Object System.Data.OleDb.OleDbCommand;
$cmd.Connection = $conn;
try {
    $conn.open();
}
catch {
    Write-Output "$Cerro-$($Error[0].ToString())";
}

$C = $PoSHQuery.C;
$Query = "INSERT INTO [dbo].[comandos] ([comando]) VALUES ('$($C)')";

$cmd.CommandText = $Query;
$cmd.ExecuteNonQuery();
$conn.close();
