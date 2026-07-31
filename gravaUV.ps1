$conn = New-Object System.Data.OleDb.OleDbConnection
$conn.ConnectionString = "Provider=SQLOLEDB;Data Source=(local);Initial Catalog=Merca;Integrated Security=SSPI;"

$cmd = New-Object System.Data.OleDb.OleDbCommand
$cmd.Connection = $conn

$cmd.CommandText = "INSERT INTO [$U].[movementos] ([tipo],[taboa],[chave],[valores]) VALUES (?, ?, ?, ?);SELECT SCOPE_IDENTITY();"

$pTipo    = $cmd.Parameters.Add("tipo",    [System.Data.OleDb.OleDbType]::Integer)
$pTaboa   = $cmd.Parameters.Add("taboa",   [System.Data.OleDb.OleDbType]::VarChar, 50)
$pChave   = $cmd.Parameters.Add("chave",   [System.Data.OleDb.OleDbType]::BigInt)
$pValores = $cmd.Parameters.Add("valores", [System.Data.OleDb.OleDbType]::LongVarChar)

$conn.Open()

# Iniciar una única transacción
$transaction = $conn.BeginTransaction()
$cmd.Transaction = $transaction

try {

    $json = $PoSHPost.M
    $U = $PoSHPost.U

    $Movementos = $json | ConvertFrom-Json | Sort-Object serial

    foreach ($m in $Movementos) {

        # el conversor anterior no hace falta porque ya viene en JSON
        $V = $([System.Web.HttpUtility]::UrlDecode($m.valores, [System.Text.Encoding]::GetEncoding("UTF-8")))

        $pTipo.Value = $m.tipo
        $pTaboa.Value = $m.taboa
        $pChave.Value = $m.chave
        $pValores.Value = $V

        $Serial = $cmd.ExecuteScalar()
    }

    # Confirmar toda la transacción
    $transaction.Commit()

}
catch {

    # Deshacer todo si falla cualquier INSERT
    $transaction.Rollback()
    throw

}
finally {

    $conn.Close()

}

$Resultado = [PSCustomObject]@{
    serial = $Serial
}

$Resultado | ConvertTo-Json
