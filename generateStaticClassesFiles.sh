## CM The intention of this script is to:
##	1.	Read in the routing table from CCR1 which is prepared by the CCR every 15 minutes.
## 	2.	Iterate through each public route and find the MAC address the IP address was last assigned to
##	3.	Prepare the .classes file for each route.
##

baseDir=/root/leaseFilesAllServers
baseDir=/opt/com21/nmaps/snmp/generateStaticClassesFiles
log=$baseDir/leaseAnalysis.log
currDate=$(date +%y%m%d%H%M)
report=$baseDir/publicSubnetsReport.tab

## Get the CCR1 routing table
scp pnetadmin@10.1.1.63://CCR1Routes.terse.txt $baseDir/CCR1Routes.terse.txt
cp $baseDir/CCR1Routes.terse.txt $baseDir/CCR1Routes.terse1.txt
## Write new routing table wich in the final format the Python script will use. We don't want comments and /32 routes.
grep -v "#" $baseDir/CCR1Routes.terse1.txt | grep -v "/32"> $baseDir/CCR1Routes.terse.txt

echo "Analysing Routes. Please wait......."
echo ""

subnetFile=/root/leaseFilesAllServers/CCR1Routes.terse.txt
pythonScriptOutput=/root/leaseFilesAllServers/leasesOutput.csv

## Dump the leases using python tool and analyse using my magic script!

## This was for lease analysis
#/root/leaseFilesAllServers/parseLeasesCM.csv.py > $pythonScriptOutput

$baseDir/analyseCCR1_Routes.py
$baseDir/analyseCCR1_Routes.py > $report
mv /opt/com21/nmaps/snmp/generateStaticClassesFiles/*.classes /opt/com21/nmaps/snmp/generateStaticClassesFiles/classes
echo ""
echo "These reports have been generated also"
echo $report
echo ""
echo ""
echo ""
