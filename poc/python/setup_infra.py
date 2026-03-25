#!/usr/bin/env python3
"""Create AWS RDS PostgreSQL and Okta groups for IAM POC."""

import os
import time
from okta.client import Client as OktaClient
import boto3

AWS_REGION = os.environ.get("AWS_REGION", "us-east-1")
RDS_INSTANCE_ID = os.environ.get("RDS_INSTANCE_ID", "iam-poc-db")
DB_NAME = os.environ.get("DB_NAME", "iam_poc")
DB_USERNAME = os.environ.get("DB_USERNAME", "iamadmin")
DB_PASSWORD = os.environ.get("DB_PASSWORD", "IamPocPassw0rd!")
OKTA_EDP_DATA_ENGINEERS = os.environ.get("OKTA_EDP_DATA_ENGINEERS", "EDP-DataEngineers")
OKTA_EDP_ANALYSTS = os.environ.get("OKTA_EDP_ANALYSTS", "EDP-Analysts")


def create_okta_groups(okta_client):
    print("Creating Okta groups")
    data_engineers_group = {"profile": {"name": OKTA_EDP_DATA_ENGINEERS, "description": "EDP data engineers"}}
    analysts_group = {"profile": {"name": OKTA_EDP_ANALYSTS, "description": "EDP analysts"}}

    created = {}

    try:
        group1 = okta_client.create_group(data_engineers_group).result
        print("Created group:", group1.profile.name, group1.id)
        created['data_engineers'] = group1
    except Exception as error:
        print("Okta group creation error (data engineers):", error)

    try:
        group2 = okta_client.create_group(analysts_group).result
        print("Created group:", group2.profile.name, group2.id)
        created['analysts'] = group2
    except Exception as error:
        print("Okta group creation error (analysts):", error)

    return created


def create_aws_rds():
    print("Creating AWS RDS PostgreSQL instance")
    rds = boto3.client("rds", region_name=AWS_REGION)

    # Open default security group for rds in default vpc only for demo
    # This may be replaced by dedicated VPC/Subnet/SecurityGroup templates.
    response = rds.create_db_instance(
        DBInstanceIdentifier=RDS_INSTANCE_ID,
        AllocatedStorage=20,
        DBInstanceClass="db.t3.micro",
        Engine="postgres",
        MasterUsername=DB_USERNAME,
        MasterUserPassword=DB_PASSWORD,
        DBName=DB_NAME,
        PubliclyAccessible=False,
        StorageType="gp2",
        MultiAZ=False,
        BackupRetentionPeriod=1,
        Tags=[{"Key": "Name", "Value": "iam-poc-db"}],
        AutoMinorVersionUpgrade=True,
    )
    print("Created DB instance request", response['DBInstance']['DBInstanceIdentifier'])

    print("Waiting for DB instance to become available (this may take 10+ minutes)")
    waiter = rds.get_waiter("db_instance_available")
    waiter.wait(DBInstanceIdentifier=RDS_INSTANCE_ID)

    desc = rds.describe_db_instances(DBInstanceIdentifier=RDS_INSTANCE_ID)
    endpoint = desc["DBInstances"][0]["Endpoint"]
    print("RDS endpoint", endpoint["Address"], endpoint["Port"])
    return endpoint


def main():
    # Okta client configuration from envs
    okta_config = {
        "orgUrl": os.environ.get("OKTA_ORG_URL"),
        "token": os.environ.get("OKTA_API_TOKEN"),
    }

    if not okta_config["orgUrl"] or not okta_config["token"]:
        raise SystemExit("Missing OKTA_ORG_URL or OKTA_API_TOKEN environment variables")

    okta_client = OktaClient(okta_config)
    okta_groups = create_okta_groups(okta_client)

    endpoint = create_aws_rds()
    print("Infrastructure created successfully")
    print("Okta groups:", okta_groups)
    print("RDS endpoint:", endpoint)


if __name__ == "__main__":
    main()
