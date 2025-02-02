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

$T = $PoSHQuery.T;
$TA = $PoSHQuery.TA;
$C = $PoSHQuery.C;
$V = $PoSHQuery.V;
$U = $PoSHQuery.U;
$V = $([System.Web.HttpUtility]::UrlEncode($V, [System.Text.Encoding]::GetEncoding("ISO-8859-1")));
$V = $([System.Web.HttpUtility]::UrlDecode($V, [System.Text.Encoding]::GetEncoding("UTF-8")));

$Query = "INSERT INTO [$U].[movementos] ([tipo],[taboa],[chave],[valores]) VALUES ($($T),'$($TA)',$($C),'$($V)');SELECT SCOPE_IDENTITY() AS NewID;";
$cmd.CommandText = $Query;
$Serial = $cmd.ExecuteScalar();
$Resultado = [PSCustomObject]@{
    serial = $Serial
}
$Saida = $Resultado|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
