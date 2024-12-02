$conn = New-Object System.Data.OleDb.OleDbConnection;
$conn.ConnectionString= "Provider=SQLOLEDB;Data Source=pccheche;Initial Catalog=Merca;User Id=********;Password=********;";
$cmd = New-Object System.Data.OleDb.OleDbCommand;
$cmd.Connection = $conn;
try {
    $conn.open();
}
catch {
    Write-Output "$Cerro-$($Error[0].ToString())";
}

$Query = "EXEC [dbo].[truncaMovementos];";
$cmd.CommandText = $Query;
$Null = $cmd.ExecuteNonQuery();
$conn.close();
