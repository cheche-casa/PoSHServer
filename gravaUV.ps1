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

$json = $PoSHPost.M;
$U = $PoSHPost.U;

$Movementos = $json|ConvertFrom-Json|Sort-Object serial;

$Movementos|ForEach-Object {
    $m = $_;
    $V = $([System.Web.HttpUtility]::UrlEncode($m.valores, [System.Text.Encoding]::GetEncoding("ISO-8859-1")));
    $V = $([System.Web.HttpUtility]::UrlDecode($m.valores, [System.Text.Encoding]::GetEncoding("UTF-8")));
    

#    $Query = "INSERT INTO [$U].[movementos] ([tipo],[taboa],[chave],[valores]) VALUES ($($m.tipo),'$($m.taboa)',$($m.chave),'$($V)');SELECT SCOPE_IDENTITY() AS NewID;";
    $Query = "INSERT INTO [$U].[movementos_bak] ([tipo],[taboa],[chave],[valores]) VALUES ($($m.tipo),'$($m.taboa)',$($m.chave),'$($V)');SELECT SCOPE_IDENTITY() AS NewID;";

    $cmd.CommandText = $Query;
    $Serial = $cmd.ExecuteScalar();
}
$Resultado = [PSCustomObject]@{
    serial = $Serial
}
$Saida = $Resultado|ConvertTo-Json;
Write-Output $Saida;
$conn.close();
