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
$Query = "EXEC [dbo].[truncaMovementos] @schemaName = '$U';";
$cmd.CommandText = $Query;
$Null = $cmd.ExecuteNonQuery();
$conn.close();
