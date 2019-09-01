#
$parent_path = Split-Path -Parent $MyInvocation.MyCommand.Definition 
$pcs_path = "$parent_path\$pcs_name"
"" | Out-File -Append ".\AS2IP_IP.txt" -Encoding UTF8

$iplist = Get-content "$parent_path\AS2IP_AS.txt"
#$iplist = $iplist.split('/')
$ip_length = $iplist.length

for ($i = 0; $i -lt $ip_length; $i++) {

	$ipv4 = $iplist[$i].split("`t")[0].split('/')[0]
	#$i = $i+1
	$lg = $iplist[$i].split("`t")[0].split('/')[1]
	
	$ipv4_to_2 = -join ($ipv4.Split('.') | ForEach-Object {[System.Convert]::ToString($_,2).PadLeft(8,'0')})
	
	$ipv4_first = ""
	for ($j = -1; $j -lt $lg-1; $j++) {
		$ipv4_first = $ipv4_first + $ipv4_to_2[$j+1]
	}

	$ipv4_lastlength = 32-$lg
	$ipv4_last = ""
	for ($j = 0; $j -lt $ipv4_lastlength; $j++) { 
		$ipv4_last = $ipv4_last + "1"
	}
	
	$ipv4_all = $ipv4_first + $ipv4_last
	
	
	$ipv4_2to10_1 = ""
	for ($j = 0; $j -lt 8; $j++) { $ipv4_2to10_1 = $ipv4_2to10_1 + $ipv4_all[$j]}
	$ipv4_10_1 = [convert]::ToInt32("$ipv4_2to10_1",2)
	
	$ipv4_2to10_2 = ""
	for ($j = 8; $j -lt 16; $j++) { $ipv4_2to10_2 = $ipv4_2to10_2 + $ipv4_all[$j]}
	$ipv4_10_2 = [convert]::ToInt32("$ipv4_2to10_2",2)

	$ipv4_2to10_3 = ""
	for ($j = 16; $j -lt 24; $j++) { $ipv4_2to10_3 = $ipv4_2to10_3 + $ipv4_all[$j]}
	$ipv4_10_3 = [convert]::ToInt32("$ipv4_2to10_3",2)

	$ipv4_2to10_4 = ""
	for ($j = 24; $j -lt 32; $j++) { $ipv4_2to10_4 = $ipv4_2to10_4 + $ipv4_all[$j]}
	$ipv4_10_4 = [convert]::ToInt32("$ipv4_2to10_4",2)
	
	$ip_arrage = "$ipv4_10_1" + '.' + "$ipv4_10_2" + '.' + "$ipv4_10_3" + '.' + "$ipv4_10_4"
	
	"$ipv4" + ' ' + "$ip_arrage" | Out-File -Append ".\AS2IP_IP.txt" -Encoding UTF8
}

