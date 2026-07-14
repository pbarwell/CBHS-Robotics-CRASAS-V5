#!/bin/bash
echo "Starting n8n"
NODE_FUNCTION_ALLOW_BUILTIN=fs,path,os,child_process \
EXECUTIONS_TIMEOUT=7200 \
N8N_RUNNERS_TASK_TIMEOUT=7200 \
N8N_SECURE_COOKIE=false \
npx n8n
