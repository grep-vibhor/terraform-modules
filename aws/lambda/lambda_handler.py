from __future__ import print_function
from datetime import date, datetime, timedelta
from collections import defaultdict
import json
import boto3
import time
from botocore.exceptions import ClientError
import os
ddbRegion = os.environ['AWS_DEFAULT_REGION']
ddbTable = os.environ['DDBTable']
ddbTable =  filter(None, ddbTable.split(","))
ddbTable = [x.strip(' ') for x in ddbTable]
backupName = ddbTable
print('Backup started for:', backupName)
ddb = boto3.client('dynamodb', region_name=ddbRegion)
daysToLookBackup= int(os.environ['BackupRetention'])
daysToLookBackupL=daysToLookBackup-1
arr = []
arr1 = []
def lambda_handler(event, context):
	try:
		latestBackupCount = 0
		DelBackupCount = 0
		for (x, y) in zip(ddbTable, backupName):
			ddb.create_backup(TableName=x,BackupName=y)
		print('Backup has been taken successfully for table:', ddbTable)
		lowerDate=datetime.now() - timedelta(days=daysToLookBackupL)
		upperDate=datetime.now()
		for x in ddbTable:
			response = ddb.list_backups(TableName=x, TimeRangeLowerBound=datetime(lowerDate.year, lowerDate.month, lowerDate.day), TimeRangeUpperBound=datetime(upperDate.year, upperDate.month, upperDate.day))
			arr.append(response)
		for x in arr:
			latestBackupCount = latestBackupCount + len(x['BackupSummaries'])
		print('Total backup count in recent days:',latestBackupCount)
		deleteupperDate = datetime.now() - timedelta(days=daysToLookBackup)
		print(deleteupperDate)
		for x in ddbTable:
			response1 = ddb.list_backups(TableName=x, TimeRangeLowerBound=datetime(2017, 11, 29), TimeRangeUpperBound=datetime(deleteupperDate.year, deleteupperDate.month, deleteupperDate.day))
			arr1.append(response1)
		if latestBackupCount>=len(ddbTable)*2:
			for x in arr1:
				DelBackupCount = DelBackupCount + len(x['BackupSummaries'])
				if DelBackupCount<=0:
					print('There is no Backup to delete')
					break
				else:
					for record in x['BackupSummaries']:
						backupArn = record['BackupArn']
						ddb.delete_backup(BackupArn=backupArn)
						print(backupArn, "has deleted this backup:", backupArn)
		else:
			print ("Recent backup does not meet the deletion criteria")
	except  ClientError as e:
		print(e)
	except ValueError as ve:
		print('error:',ve)
	except Exception as ex:
		print(ex)