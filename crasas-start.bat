@echo off
echo Starting n8n 
set N8N_SECURE_COOKIE=false
set NODE_FUNCTION_ALLOW_BUILTIN=fs,path,os,child_process
set EXECUTIONS_TIMEOUT=7200
set N8N_RUNNERS_TASK_TIMEOUT=7200
npx n8n
