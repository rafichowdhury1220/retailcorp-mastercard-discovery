package iam_poc

default allow = false

allow {
    input.user.role == "POC_DATA_ENG"
    input.resource.db == "MCST"
    input.resource.schema == "landing"
    input.action == "write"
}

allow {
    input.user.role == "POC_ANALYST"
    input.resource.db == "MCST"
    input.resource.schema == "curated"
    input.action == "read"
}
